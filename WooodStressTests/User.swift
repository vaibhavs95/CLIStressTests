//
//  User.swift
//  WooodStressTests
//
//  Created by Vaibhav Singh on 18/05/18.
//  Copyright © 2018 Vaibhav. All rights reserved.
//

import Foundation

struct DummyUser {
    let authToken: String?
    let userId: String?

    static func dummy() -> [DummyUser] {
        return [DummyUser(authToken: "2sTj1-s0fa37F3WBStGASg", userId: "10")]
    }
}
