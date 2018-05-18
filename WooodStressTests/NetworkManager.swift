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
    case postDetail(id: Int)
    case likePost(post: Post)
    case comment(post: Post)
    case deletePost(id: Int)
    case getPostComments(postId: Int)
    case getPostLikes(postId: Int)

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
        case .postDetail(let id):
            return "/api/v1/post/\(id)"
        case .getPostComments(let postId):
            return "/api/v1/post/\(postId)/comments"
        case .getPostLikes(let postId):
            return "/api/v1/post/\(postId)/likes"
        }
    }
}

class Manager {

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
