//
//  Testmonial.swift
//  Plyreporter
//
//  Created by Sunita Moond on 13/12/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct Testimonial: Codable {
    var text: String?
    var user: String?
    var businessName: String?

    enum CodingKeys: String, CodingKey {
        case text = "text"
        case user =  "submitter"
        case businessName = "submitter_business"
    }
}
