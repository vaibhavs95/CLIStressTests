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
        case .getUserFeed(let id):
            return "/api/v1/timeline/user_feed?user_feed=\(id)"
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
                return ["user_id": id]
            default:
                return nil
        }
    }

    func asURLRequest() throws -> URLRequest? {
        guard let url = URL(string: NetworkManager.baseUrl)?.appendingPathComponent(path) else
            { throw APIError.invalidURL(reason: "Url couldn't be generated.") }
        do {
            var urlRequest = URLRequest(url: url)
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

    func decodeResponse<T: Codable>(data: Data?, type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T? {
        do {
            if let data = data {
                let response = try decoder.decode(Response<T>.self, from: data)
                print(response.result as Any)
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
