//
//  User.swift
//  Plyreporter
//
//  Created by Koushal Sharma on 31/10/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var id: Int?
    var email: String?
    var name: String?
    var contactNumber: String?
    var firebaseId: String?
    var authenticationToken: String?
    var renewToken: String?
    var newUser: Bool?
    var image: String?
    var businessProfileId: Int?
    var cityId: Int?
    var stateId: Int?
    var companyName: String?
    var city: FilterCategory?
    var state: FilterCategory?
    var businessProfile: FilterCategory?
    var isSelected = true
    var isFollowing: Bool?
    var followersCount: Int?
    var followingsCount: Int?
    var imageURL: URL? {
        return URL(str: image)
    }

    enum CodingKeys: String, CodingKey {
     
        case id
        case email
        case name
        case contactNumber = "contact_number"
        case firebaseId = "firebase_id"
        case authenticationToken = "authentication_token"
        case renewToken = "renew_token"
        case newUser = "new_user"
        case image
        case businessProfileId = "business_profile_id"
        case cityId = "city_id"
        case stateId = "country_state_id"
        case companyName = "business_name"
        case city
        case state
        case businessProfile = "business_profile"
        case isFollowing = "is_following"
        case followingsCount = "followings_count"
        case followersCount = "followers_count"
    }
}

extension User: Equatable {

    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
                lhs.name == rhs.name &&
                lhs.businessProfile?.name == rhs.businessProfile?.name &&
                lhs.companyName == rhs.companyName &&
                lhs.city?.name == rhs.city?.name &&
                lhs.state?.name == rhs.state?.name &&
                lhs.image == rhs.image
    }
}

struct Friends: Codable {

    var contactNumbers: [String]

    enum CodingKeys: String, CodingKey {

        case contactNumbers = "contact_numbers"
    }
}

struct BulkFollow: Codable {

    var userIds: [Int?]?

    enum CodingKeys: String, CodingKey {

        case userIds =  "user_ids"
    }
}

struct FollowOrUnFollow: Codable {
    
    var userId: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case userId = "user_id"
    }
}

struct BulkFollowResult: Codable {

    var friends: [User]?

    enum CodingKeys: String, CodingKey {

        case friends =  "friends"
    }
}

struct FindFriendsResult: Codable {

    var friends: [User]?

    enum CodingKeys: String, CodingKey {
        
        case friends = "array"
    }
}

extension User {
    init(contactNumber: String?, firebaseId: String?) {
        self.contactNumber = contactNumber
        self.firebaseId = firebaseId
    }

    init(firebaseId: String?) {
        self.firebaseId = firebaseId
    }

    init(name: String?, image: String? = nil, businessProfileId: Int? = nil, cityId: Int? = nil, stateId: Int?  = nil, companyName: String? = nil ) {
        self.name = name
        self.image = image
        self.businessProfileId = businessProfileId
        self.stateId = stateId
        self.cityId = cityId
        self.companyName = companyName
    }
}

struct Users: Codable {
    
    var users: [User]?
    
    enum CodingKeys: String, CodingKey {
        
        case users
    }
}

struct Followers: Codable {
    
    var followers: [User]?
    
    enum CodingKeys: String, CodingKey {
        
        case followers
    }
}

struct Followings: Codable {
    
    var followings: [User]?
    
    enum CodingKeys: String, CodingKey {
        
        case followings
    }
}
