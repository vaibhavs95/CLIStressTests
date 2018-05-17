//
//  Review.swift
//  Plyreporter
//
//  Created by Sunita Moond on 31/10/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct Review: Codable {

    var id: Int?
    var revieweeId: Int?
    var reviewer: User?
    var reviewee: User?
    var rating: Double?
    var comment: String?
    var createAt: Date?

    enum CodingKeys: String, CodingKey {
        
        case id
        case reviewer
        case reviewee
        case rating
        case comment
        case revieweeId = "reviewee_id"
        case createAt = "created_at"
    }
}

struct ReviewRecords: Codable {

    var totalRecords: Int?
    var reviews: [Review] = []

    enum CodingKeys: String, CodingKey {
        
        case totalRecords = "total_records"
        case reviews = "records"
    }
}

extension Review {

    init(revieweeId: Int? = nil, rating: Double?, comment: String?) {
        self.revieweeId = revieweeId
        self.rating = rating
        self.comment = comment
    }

    init(testimonial: Testimonial) {
        self.comment = testimonial.text
        self.reviewer?.name = testimonial.user
        self.reviewee?.name = testimonial.businessName
    }
}

struct ReviewResult: Codable {

    var review: Review?

    enum CodingKeys: String, CodingKey {

        case review
    }
}
