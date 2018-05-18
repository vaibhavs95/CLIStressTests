//
//  Product.swift
//  Plyreporter
//
//  Created by Sunita Moond on 06/12/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct Product: Codable {
    var id: Int?
    var name: String?
    var subCategory: [Product]?
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {

        case id
        case name
        case subCategory = "sub_category"
    }
}
