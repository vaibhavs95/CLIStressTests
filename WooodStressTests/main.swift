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

let decoder = JSONDecoder()
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
decoder.dateDecodingStrategy = .formatted(dateFormatter)


let post = Post(postId: nil, commentText: nil, content: "something", attachment: nil, author: nil)
let createPost = NetworkManager(type: .createPost(post: post), authToken: "2sTj1-s0fa37F3WBStGASg", userID: "10")
createPost.creteTask(type: CreatePostReponse.self) {
    print("post created")
}

let another = NetworkManager(type: .getUserFeed(id: 10), authToken: "2sTj1-s0fa37F3WBStGASg", userID: "10")
another.creteTask(type: TimelineResponse.self, decoder: decoder) {
    print("User Feed!")
}

sema.wait()


