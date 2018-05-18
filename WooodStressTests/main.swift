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

enum type: Int {
    case getTimeline = 0
    case getUserFeed
    case createPost
    case getPostDetail
    case likePost
    case comment
    case deletePost
    case getAllComments
    case getAllLikes
}

struct TimeCalcultion {
    var min: Double = 9999
    var max: Double = -999999
    var average: Double = 0
    var totalResponse: Int = 0
}

var arr: [TimeCalcultion] = [TimeCalcultion](repeating: TimeCalcultion(), count: 9)
var timer: Timer?

let decoder = JSONDecoder()
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
decoder.dateDecodingStrategy = .formatted(dateFormatter)

fileprivate func timeCalculationForAPIResponse(_ index: Int, _ date: Date) {
    arr[index].min =  arr[index].min < -date.timeIntervalSinceNow ? arr[index].min : -date.timeIntervalSinceNow
    arr[index].max = arr[index].max > -date.timeIntervalSinceNow ? arr[index].max : -date.timeIntervalSinceNow
    arr[index].average =  (arr[index].average * Double(arr[index].totalResponse) + -date.timeIntervalSinceNow) / Double(arr[index].totalResponse + 1)
    arr[index].totalResponse = arr[index].totalResponse + 1
}

let index = type.getUserFeed.rawValue
Timer.scheduledTimer(withTimeInterval:1, repeats: true, block: {(timer) in
    let date = Date()
    let another = NetworkManager(type: .getUserFeed(id: 10), authToken: "2sTj1-s0fa37F3WBStGASg", userID: "10")
    another.creteTask(type: TimelineResponse.self, decoder: decoder) {
        timeCalculationForAPIResponse(index, date)

        if arr[index].totalResponse == 2 {
            timer.invalidate()
        }
        print(arr[index])
        print("User Feed!")
    }
})

sema.wait()


