//
//  Enquiry.swift
//  Plyreporter
//
//  Created by Sunita Moond on 10/11/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct Enquiry: Codable {

    var id: Int?
    var description: String?
    var enquire: User?
    var replier: User?
    var enquiryOn: Date?

    enum CodingKeys: String, CodingKey {

        case id
        case description = "body"
        case enquire
        case replier
        case enquiryOn = "enquired_on"
    }
}

extension Enquiry {

    init(id: Int?, description: String?) {
        self.id = id
        self.description = description
    }
}
