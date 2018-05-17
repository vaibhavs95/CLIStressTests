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

extension FilterCategory {

    init(id: Int, name: String, subCategories: [FilterCategory]) {
        self.id = id
        self.name = name
        self.subCategories = subCategories
    }

    static func getDummyData() -> [FilterCategory] {
        let filters: [FilterCategory] =
            [FilterCategory(id: 1, name: "Raw Material Supplier", subCategories:
                            [FilterCategory(id: 1, name: "Face Veneer", subCategories: []),
                             FilterCategory(id: 2, name: "Popular Veneer", subCategories: [])]
                            ),
             FilterCategory(id: 2, name: "Machinery Suppliers", subCategories:
                            [FilterCategory(id: 3, name: "Peeling", subCategories: []),
                             FilterCategory(id: 4, name: "Dryers", subCategories: [])]
                            ),
             FilterCategory(id: 3, name: "Manufacturers", subCategories:
                            [FilterCategory(id: 5, name: "Plywood", subCategories:
                                        [FilterCategory(id: 7, name: "All Red", subCategories: []),
                                         FilterCategory(id: 8, name: "All Popular", subCategories: []),
                                         FilterCategory(id: 43, name: "Dryrs", subCategories: []),
                                         FilterCategory(id: 41, name: "Dryes", subCategories: []),
                                         FilterCategory(id: 42, name: "Dryer", subCategories: [])]
                                            ),
                            FilterCategory(id: 6, name: "Black Boards", subCategories: [])
                            ]),
             FilterCategory(id: 4, name: "Distributors", subCategories: []),
             FilterCategory(id: 5, name: "Retailers", subCategories: [])]
        return filters
    }
}

