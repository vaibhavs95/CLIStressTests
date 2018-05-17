//
//  Bookmark.swift
//  Plyreporter
//
//  Created by Vaibhav Singh on 31/10/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct Bookmark: Codable {
    
    var id: Int?
    var user: User?
    var bookmarkable: User?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case user = "marker"
        case bookmarkable
        case type
    }
}

struct BookmarkRequest: Codable {
    
    var id: Int?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "bookmarkable_id"
        case type = "bookmarkable_type"
    }
}

struct BookMarkResponse: Codable {
    
    var totalRecords: Int?
    var vendor: [BusinessProfile]?
    var news: [NewsProfile]?

    enum CodingKeys: String, CodingKey {
        
        case totalRecords = "total_records"
        case vendor
        case news
    }
}

enum BookMarkType: String {
    
    case news = "news"
    case vendor = "vendor"
}
