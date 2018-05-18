//
//  Folder.swift
//  Plyreporter
//
//  Created by Sunita Moond on 23/01/18.
//  Copyright © 2018 moldedbits. All rights reserved.
//

import Foundation

struct Folder: Codable {

    var id: Int
    var name: String?
    var image: String?
    var imageURL: URL? {
        guard let url = image else { return nil }

        return URL(string: url)
    }
    var sections: [FolderSection]?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case sections
    }
}

struct FolderSection: Codable {
    var name: String?
    var items: [Item]

    enum CodingKeys: String, CodingKey {
        case name
        case items
    }
}

struct Item: Codable {
    var name: String?
    var sku: String?
    var images: [Assests]

    enum CodingKeys: String, CodingKey {
        case name
        case sku
        case images
    }
}

struct FolderDetailResult: Codable {
    var folder: Folder

    enum CodingKeys: String, CodingKey {
        case folder
    }
}

struct AllFolder: Codable {
    var products: [Product]

    enum CodingKeys: String, CodingKey {
        case products
    }
}

struct FolderVendors: Codable {
    var totalVandors: Int = 0
    var vendors: [BusinessProfile]


    enum CodingKeys: String, CodingKey {
        case totalVandors = "total_count"
        case vendors
    }
}

struct FolderResult: Codable {
    var total: Int = 0
    var folders: [Folder]


    enum CodingKeys: String, CodingKey {
        case total = "total_count"
        case folders
    }
}
