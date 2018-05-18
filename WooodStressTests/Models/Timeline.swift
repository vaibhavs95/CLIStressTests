//
//  Timeline.swift
//  Plyreporter
//
//  Created by Koushal Sharma on 07/02/18.
//  Copyright © 2018 moldedbits. All rights reserved.
//

import Foundation

struct Timeline: Codable {
    
    var id: Int?
    var content: String?
    var attachment: Attachment?
    var totalLikes: Int?
    var totalComments: Int?
    var isLiked: Bool?
    var isPlyreporter: Bool?
    var author: User?
    var latestActivity: LatestActivity?
    var updatedAt: Date?
    var comments: [PostComment]?
    var likes: [User]?

    enum CodingKeys: String, CodingKey {
        
        case id
        case content
        case attachment
        case totalLikes = "total_likes"
        case totalComments = "total_comments"
        case isLiked = "is_liked"
        case isPlyreporter = "is_ply_reporter"
        case author
        case latestActivity = "latest_activity"
        case updatedAt = "updated_at"
        case comments
        case likes
    }
}

extension Timeline: Equatable {

    static func ==(lhs: Timeline, rhs: Timeline) -> Bool {
        return lhs.id == rhs.id &&
            lhs.totalLikes == rhs.totalLikes &&
            lhs.totalComments == rhs.totalComments &&
            lhs.isLiked == rhs.isLiked 
    }
}

enum UserActivityType: String, Codable {

    case post = "Post"
    case like = "Like"
    case comment = "Comment"
    case follow = "Follow"

    var activityString: String {
        switch self {
            case .like: return "liked"
            case .comment: return "commented on"
            case .post: return "posted"
            case .follow: return "follow"
        }
    }
}

struct LatestActivity: Codable {

    var actor: User?
    var verb: UserActivityType?
    var count: Int?

    enum CodingKeys: String, CodingKey {

        case actor
        case verb
        case count
    }
}

struct Post: Codable {

    var postId: Int?
    var commentText: String?
    var content: String?
    var attachment: Attachment?
    var author: User?

    enum CodingKeys: String, CodingKey {

        case postId = "post_id"
        case commentText = "comment_text"
        case content
        case attachment
        case author
    }
}

struct CommentId: Codable {

    var commentId: Int?

    enum CodingKeys: String, CodingKey {

        case commentId = "comment_id"
    }
}

struct CommentResult: Codable {

    var id: Int?
    var comment: String?
    var author: User?

    enum CodingKeys: String, CodingKey {

        case id
        case comment
        case author
    }
}

struct TimelinePostResponse: Codable {

    var user: User?
    var posts: [Timeline]?
    var lastUUID: String?
    var lastId: Int?

    enum CodingKeys: String, CodingKey {

        case user
        case posts
        case lastUUID = "last_uuid"
        case lastId = "last_id"
    }
}

struct TimelineResponse: Codable {

    var timeline: TimelinePostResponse?

    enum CodingKeys: String, CodingKey {

        case timeline
    }
}

struct CreatePostReponse: Codable {

    var id: Int

    enum CodingKeys: String, CodingKey {

        case id
    }
}

struct PostLikes: Codable {
    
    var likes: [User]?
    var totalLikes: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case likes
        case totalLikes = "total_likes"
    }
}

struct PostCommentsResponse: Codable {
    
    var totalComments: Int?
    var comments: [PostComment]?
    
    enum CodingKeys: String, CodingKey {
        
        case totalComments = "total_comments"
        case comments
    }
}

struct PostComment: Codable {
    
    var id: Int?
    var title: String?
    var comment: String?
    var author: User?
    var updatedAt: Date?
    var replyCount: Int?
    var replies: [PostComment]?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case title
        case comment
        case author
        case updatedAt = "updated_at"
        case replyCount = "reply_count"
        case replies
    }
}

struct PostDetail: Codable {

    var post: Timeline

    enum CodingKeys: String, CodingKey {

        case post
    }
}

struct CommentDetail: Codable {

    var comment: PostComment?
    var replies: [PostComment]?
    var replyCount: Int?

    enum CodingKeys: String, CodingKey {

        case comment
        case replies
        case replyCount = "reply_count"
    }
}

struct CommentDetailResult: Codable {

    var comment: PostComment?

    enum CodingKeys: String, CodingKey {

        case comment
    }
}

struct CommentReply: Codable {

    var id: Int?
    var comment: String?

    enum CodingKeys: String, CodingKey {

        case id = "comment_id"
        case comment = "comment_text"
    }
}

extension Post {

    init(timeline: Timeline?) {
        self.postId = timeline?.id
        self.content = timeline?.content
        self.attachment = timeline?.attachment
        self.author = timeline?.author
    }
}

struct Attachment: Codable {
    
    var url: String?
    var attachmentType: AssestsType?
    
    enum CodingKeys: String, CodingKey {
        
        case url
        case attachmentType = "attachment_type"
    }
}
