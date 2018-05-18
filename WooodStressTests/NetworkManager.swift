//
//  NetworkManager.swift
//  WooodStressTests
//
//  Created by Vaibhav Singh on 18/05/18.
//  Copyright © 2018 Vaibhav. All rights reserved.
//

import Foundation

enum Router {

    case getTimeline
    case getUserFeed(id: Int)
    case createPost(post: Post)
    case getPostDetail(id: Int)
    case likePost(post: Post)
    case comment(post: Post)
    case deletePost(id: Int)
    case getAllComments(postId: Int)
    case getAllLikes(postId: Int)

    var method: HTTPMethod {
        switch self {
            case .getTimeline, .getUserFeed, .getAllLikes, .getAllComments, .getPostDetail: return .get
            case .likePost, .comment, .createPost: return .post
            case .deletePost: return .delete
        }
    }

    var path: String {
        switch self {
        case .getTimeline:
            return "/api/v1/timeline"
        case .likePost:
            return "/api/v1/likes"
        case .comment:
            return "/api/v1/comments"
        case .createPost:
            return "/api/v1/post"
        case .deletePost(let id):
            return "/api/v1/post/\(id)"
        case .getUserFeed:
            return "/api/v1/timeline/user_feed"
        case .getPostDetail(let id):
            return "/api/v1/post/\(id)"
        case .getAllComments(let postId):
            return "/api/v1/post/\(postId)/comments"
        case .getAllLikes(let postId):
            return "/api/v1/post/\(postId)/likes"
        }
    }

    var parameters: [String: Any]? {
        switch self {
            case .getUserFeed(let id):
                return ["user_id": "\(id)"]
            default:
                return nil
        }
    }

    func asURLRequest() throws -> URLRequest? {
        guard let url = URL(string: NetworkManager.baseUrl)?.appendingPathComponent(path) else
            { throw APIError.invalidURL(reason: "Url couldn't be generated.") }
        do {
            var urlRequest = URLRequest(url: url)
            if case Router.getUserFeed = self {
                var components = URLComponents(string: "https://ply-reporter-dev.herokuapp.com/api/v1/timeline/user_feed")
                components?.queryItems = [URLQueryItem(name: (self.parameters?.first?.key)!, value: (self.parameters?.first?.value) as? String)]
                urlRequest.url = components?.url
            }
            urlRequest.httpMethod = method.rawValue
            urlRequest.allHTTPHeaderFields = NetworkManager.authorizationHeaders
            let encoder = JSONEncoder()
            switch self {
            case .createPost(let post), .likePost(let post), .comment(let post):
                urlRequest.httpBody = try encoder.encode(post)

                return urlRequest
            default:
                return urlRequest
            }
        } catch let error {
            throw APIError.parameterEncodingFailed(reason: error.localizedDescription)
        }
    }
}

class NetworkManager {

    static let baseUrl: String = "https://ply-reporter-dev.herokuapp.com"
    static let authorizationHeaders: [String : String] = ["Authorization" : "Basic YWRtaW46ZG90c2xhc2g=",
                                                         "Content-Type" : "application/json; charset=utf-8",
                                                         "User-Language" : "en" ]
    let authToken: String!
    let userId: String!
    let type: Router!
    var request: URLRequest?

    init(type: Router, authToken: String, userID: String) {
        self.authToken = authToken
        self.userId = userID
        self.type = type
    }

    private func setup() {
        do {
            request = try type.asURLRequest()
            request?.addValue(authToken, forHTTPHeaderField: "Authentication-Token")
            request?.addValue(userId, forHTTPHeaderField: "User-Id")
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func creteTask<T: Codable>(type: T.Type, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (() -> ())) {
        setup()
        guard let urlRequest = request else { return }
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                completion()
                let response = self.decodeResponse(data: data, type: type, decoder: decoder)
                print(response as Any)
            }
        }
        dataTask.resume()
    }

    func decodeResponse<T: Codable>(data: Data?, type: T.Type, decoder: JSONDecoder) -> T? {
        do {
            if let data = data {
                let response = try decoder.decode(Response<T>.self, from: data)
                return response.result
            }
        } catch let error {
            print("Error while decoding -> \(error.localizedDescription)")
        }
        return nil
    }
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
