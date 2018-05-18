//
//  NewsCategory.swift
//  Plyreporter
//
//  Created by Koushal Sharma on 07/11/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct NewsCategory: Codable {
    
    var id: Int?
    var category: String?
    var records: [NewsProfile]
    var totalRecords: Int
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case category
        case records
        case totalRecords = "total_records"
    }
}
