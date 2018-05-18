//
//  NewsProfile.swift
//  Plyreporter
//
//  Created by Koushal Sharma on 07/11/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct NewsProfile: Codable {
    
    var id: Int?
    var title: String?
    var shortDesc: String?
    var asset: Assests?
    var readTime: Int?
    var author: String?
    var authoredOn: Date?
    var content: String?
    var category: String?
    var bookMarkableType: String?
    var isBookmarked: Bool?
    var userBookmark: Bookmark?
    var imageURL: URL? {
        guard let image = asset?.url else { return nil }
        
        return URL(string: image)
    }

    enum CodingKeys: String, CodingKey {
        
        case id
        case title
        case asset
        case shortDesc = "short_desc"
        case readTime = "read_time"
        case author
        case authoredOn = "authored_on"
        case content
        case category
        case bookMarkableType = "bookmarkable_type"
        case isBookmarked = "is_bookmarked"
        case userBookmark = "user_bookmark"
    }
}
