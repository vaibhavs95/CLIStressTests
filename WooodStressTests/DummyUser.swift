//
//  User.swift
//  WooodStressTests
//
//  Created by Vaibhav Singh on 18/05/18.
//  Copyright © 2018 Vaibhav. All rights reserved.
//

import Foundation

struct DummyUser {

    let authToken: String
    let userId: String

    static let current: [DummyUser] = [
        DummyUser(authToken: "2sTj1-s0fa37F3WBStGASg", userId: "10"),
        DummyUser(authToken: "Gezv9OG4ftD1pQrHY8YJcA", userId: "6"),
        DummyUser(authToken: "CP8FdMV4QI6JrWQF1977wA", userId: "20"),
        DummyUser(authToken: "uGPf5E2k49HWohHaQiEEWQ", userId: "7"),
        DummyUser(authToken: "1XFHv_ffNbE6lAPC1235MA", userId: "8"),
        DummyUser(authToken: "KxiUr2ay_1hD7s6_LdwQsQ", userId: "30"),
        DummyUser(authToken: "85NEta6eZxHOZd11jhaRdQ", userId: "33")
    ]

    static func getUsers(_ count: Int) -> [DummyUser] {
        let upperLimit = count < DummyUser.current.count ? count : DummyUser.current.count
        return Array(DummyUser.current.prefix(upperLimit))
    }
}
