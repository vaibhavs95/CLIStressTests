//
//  BusinessCategory.swift
//  Plyreporter
//
//  Created by Koushal Sharma on 06/11/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct BusinessCategory: Codable {
    
    var id: Int?
    var category: String?
    var businesses: [BusinessProfile]
    var filters: [FilterCategory]?
    var totalRecords: Int
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case category
        case businesses
        case filters
        case totalRecords = "total_records"
    }
}

struct ConfigureLimitation {
    
    var limit: Int
    var offset: Int
    var category: Int?
    var filterIds: [Int]?
    var bookMarkType: BookMarkType?
    var stateIds: [Int]?
    var query: String?
    var postId: Int?
    var lastUUID: String?
    var lastId: Int?
}

extension ConfigureLimitation {

    init(limit: Int = 0, offset: Int = 0, categoryId: Int? = nil, query: String? = nil) {
        self.query = query
        self.limit = limit
        self.offset = offset
        self.category = categoryId
    }
    
    init(limit: Int, offset: Int, bookMarkType: BookMarkType) {
        self.limit = limit
        self.offset = offset
        self.bookMarkType = bookMarkType
    }

    init(limit: Int, offset: Int, categoryId: Int, stateIds: [Int]?, filterIds: [Int]?, query: String? = nil) {
        self.query = query
        self.limit = limit
        self.offset = offset
        self.category = categoryId
        self.stateIds = stateIds
        self.filterIds = filterIds
    }
    
    init(limit: Int, offset: Int, postId: Int) {
        self.limit = limit
        self.offset = offset
        self.postId = postId
    }
    
    init(lastUUID: String, lastId: Int) {
        self.limit = 0
        self.offset = 0
        self.lastUUID = lastUUID
        self.lastId = lastId
    }

    init(lastUUID: String) {
        self.limit = 0
        self.offset = 0
        self.lastUUID = lastUUID
    }
}
