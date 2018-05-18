//
//  main.swift
//  WooodStressTests
//
//  Created by Vaibhav Singh on 17/05/18.
//  Copyright © 2018 Vaibhav. All rights reserved.
//
import Foundation

var sema = DispatchSemaphore( value: 0 )

print("Hello, World!")

let url = "https://ply-reporter-dev.herokuapp.com/api/v1/timeline"

var urlRequest = URLRequest(url: URL(string: url)!)

urlRequest.allHTTPHeaderFields =  ["Authorization" : "Basic YWRtaW46ZG90c2xhc2g=",
                                   "Content-Type" : "application/json; charset=utf-8",
                                   "User-Language" : "en",
                                   "User-Id" : "10",
                                   "Authentication-Token" : "2sTj1-s0fa37F3WBStGASg" ]

let decoder = JSONDecoder()
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
decoder.dateDecodingStrategy = .formatted(dateFormatter)

let another = NetworkManager(type: .getUserFeed(id: 10), authToken: "2sTj1-s0fa37F3WBStGASg", userID: "10")
another.creteTask(type: TimelineResponse.self, decoder: decoder) {
    print("User Feed!")
}

sema.wait()


