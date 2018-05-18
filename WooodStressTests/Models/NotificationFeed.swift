//
//  NotificationFeed.swift
//  Plyreporter
//
//  Created by Koushal Sharma on 07/03/18.
//  Copyright © 2018 moldedbits. All rights reserved.
//

import Foundation

struct NotificationResponse: Codable {
    
    var notificationFeed: NotificationFeed?
    
    enum CodingKeys: String, CodingKey {
        
        case notificationFeed = "notification_feed"
    }
}

struct NotificationFeed: Codable {
    
    var lastUUID: String?
    var notifications: [Notifications]
    
    enum CodingKeys: String, CodingKey {
        
        case lastUUID = "last_uuid"
        case notifications
    }
}

struct Notifications: Codable {
    
    var type: UserActivityType?
    var id: String?
    var activities: [NotificationActivity]?
    
    enum CodingKeys: String, CodingKey {
        
        case type
        case id
        case activities
    }
}

struct NotificationActivity: Codable {
    
    var actor: User?
    var post: Timeline?
    
    enum CodingKeys: String, CodingKey {
        
        case actor
        case post
    }
}
