//
//  BusinessProfile.swift
//  Plyreporter
//
//  Created by Koushal Sharma on 06/11/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct BusinessProfile: Codable {
    
    var id: Int?
    var name: String?
    var email: String?
    var address: String?
    var rating: Double?
    var logo: String?
    var contact: String?
    var assets: [Assests]?
    var productSpecialisation: [String]?
    var bookmarkType: String?
    var businessType: String?
    var reviewCount: Int?
    var bookmarkCount: Int?
    var enquiryCount: Int?
    var isEnquired: Bool?
    var userEnquiry: Enquiry?
    var isReviewed: Bool?
    var isBookmarked: Bool?
    var userReview: Review?
    var userBookmark: Bookmark?
    var reviews: [Review]?
    var state: String?
    var testimonials: [Testimonial]?
    var isTestimonialProvide: Bool? {
        guard (testimonials?.count ?? 0) > 0 else { return false }

        return true
    }
    var logoImageURL: URL? {
        guard let image = logo else { return nil }
        
        return URL(string: image)
    }
    var coverImages : [URL]? {
        var p: [URL] = []
        guard let assets = assets else { return nil }
        for asset in assets {
            guard let url = URL(string: asset.url ?? "") else { return nil}
            p.append(url)
        }
        
        return p
    }
    var isFeatured: Bool?

    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case email = "cc_email"
        case address
        case rating
        case logo
        case contact = "contact_number"
        case assets = "assets"
        case productSpecialisation = "product_specialisation"
        case bookmarkType = "bookmarkable_type"
        case businessType = "business_type"
        case reviewCount = "review_count"
        case bookmarkCount = "bookmark_count"
        case enquiryCount = "enquiry_count"
        case isEnquired = "is_enquired"
        case userEnquiry = "user_enquiry"
        case isReviewed =  "is_reviewed"
        case isBookmarked = "is_bookmarked"
        case userReview = "user_review"
        case userBookmark = "user_bookmark"
        case reviews
        case state
        case testimonials = "testimonials"
        case isFeatured = "is_featured"
    }
}

extension BusinessProfile {

    init(folder: Folder) {
        self.id = folder.id
        self.name = folder.name
        self.logo = folder.image
    }
}

struct Assests: Codable {

    var url: String?
    var type: String?
    var image: String?

    enum CodingKeys: String, CodingKey {

        case url
        case type
        case image
    }
}


enum AssestsType: String, Codable {
    
    case image = "image"
    case video = "video"
}
