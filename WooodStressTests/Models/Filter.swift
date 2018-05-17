//
//  Filter.swift
//  Plyreporter
//
//  Created by Koushal Sharma on 07/11/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct FilterCategory: Codable {

    var id: Int
    var name: String?
    var subCategories: [FilterCategory]?
    var isSelected: Bool = false
    var description: [String?] = []
    var parentIndex: Int = 0

    enum CodingKeys: String, CodingKey {

        case id
        case name
        case subCategories = "sub_category"
    }

    var selected: [Int] {
        if let subCategories = subCategories, !subCategories.isEmpty {
            return subCategories.flatMap { $0.selected }
        } else {
            return isSelected ? [id] : []
        }
    }
}

