//
//  Advertisement.swift
//  Plyreporter
//
//  Created by Sunita Moond on 06/11/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct Advertisement: Codable {
    
    var id: Int?
    var title: String?
    var description: String?
    var section: String?
    var type: String?
    var image: Assests?
    var imageURL: URL? {
        guard let image = image?.url else { return nil }

        return URL(string: image)
    }
    var redirect: String?
    var redirectURL: URL? {
        guard let redirect = redirect else { return nil }

        return URL(string: redirect )
    }

    enum CodingKeys: String, CodingKey {
        
        case id
        case title
        case description
        case section
        case type
        case image = "asset"
        case redirect = "redirect_url"
    }
}
