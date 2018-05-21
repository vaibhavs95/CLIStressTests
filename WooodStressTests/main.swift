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

enum APIType: Int {
    case getTimeline = 0
    case getUserFeed
    case createPost
    case getPostDetail
    case likePost
    case comment
    case getAllComments
    case getAllLikes
    case deletePost
}

struct TimeCalcultion {
    var min: Double = 9999
    var max: Double = -999999
    var average: Double = 0
    var totalResponse: Int = 0
}

var arr: [TimeCalcultion] = [TimeCalcultion](repeating: TimeCalcultion(), count: 9)
var timer: Timer?

func timeCalculationForAPIResponse(_ index: Int, _ date: Date) {
    arr[index].min =  arr[index].min < -date.timeIntervalSinceNow ? arr[index].min : -date.timeIntervalSinceNow
    arr[index].max = arr[index].max > -date.timeIntervalSinceNow ? arr[index].max : -date.timeIntervalSinceNow
    arr[index].average =  (arr[index].average * Double(arr[index].totalResponse) + -date.timeIntervalSinceNow) / Double(arr[index].totalResponse + 1)
    arr[index].totalResponse = arr[index].totalResponse + 1
}

func makeAPICall(index: Int, user: DummyUser) {
    let date = Date()
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    switch index{
    case 0:
        let timeline = NetworkManager(type: .getTimeline, authToken: "2sTj1-s0fa37F3WBStGASg", userID: "10")
        timeline.creteTask(type: TimelineResponse.self, decoder: decoder) {
            timeCalculationForAPIResponse(index, date)
        }
    case 1:
        let getUserFeed = NetworkManager(type: .getUserFeed(id: 10), authToken: "2sTj1-s0fa37F3WBStGASg", userID: "10")
        getUserFeed.creteTask(type: TimelineResponse.self, decoder: decoder) {
            timeCalculationForAPIResponse(index, date)
        }
    case 2:
        let post = Post(postId: nil, commentText: nil, content: "something", attachment: nil, author: nil)
        let createPost = NetworkManager(type: .createPost(post: post), authToken: DummyUser.current[0].authToken, userID: DummyUser.current[0].userId)
        createPost.creteTask(type: CreatePostReponse.self) {
            timeCalculationForAPIResponse(index, date)
        }

    case 3:
        let postDetail = NetworkManager(type: .getPostDetail(id: 806), authToken: "2sTj1-s0fa37F3WBStGASg", userID: "10")
        postDetail.creteTask(type: PostDetail.self, decoder: decoder) {
            timeCalculationForAPIResponse(index, date)
        }
    case 4:
        let likePost = NetworkManager(type: .likePost(post: Post(postId: 806, commentText: nil, content: nil, attachment: nil, author: nil)), authToken: "2sTj1-s0fa37F3WBStGASg", userID: "10")
        likePost.creteTask(type: PostDetail.self, decoder: decoder) {
            timeCalculationForAPIResponse(index, date)
        }
    case 5:
        let post = Post(postId: 806, commentText: "this is the comment", content: nil, attachment: nil, author: nil)
        let commentOnPost = NetworkManager(type: .comment(post: post), authToken: "2sTj1-s0fa37F3WBStGASg", userID: "10")
        commentOnPost.creteTask(type: PostDetail.self, decoder: decoder) {
            timeCalculationForAPIResponse(index, date)
        }
    case 6:
        let likes = NetworkManager(type: .getAllLikes(postId: 806), authToken: "2sTj1-s0fa37F3WBStGASg", userID: "10")
        likes.creteTask(type: PostLikes.self, decoder: decoder) {
            timeCalculationForAPIResponse(index, date)
        }
    case 7:
        let comments = NetworkManager(type: .getAllLikes(postId: 806), authToken: "2sTj1-s0fa37F3WBStGASg", userID: "10")
        comments.creteTask(type: PostCommentsResponse.self, decoder: decoder) {
            timeCalculationForAPIResponse(index, date)
        }
    //    case 8: //TODO: delete
    default:
        let timeline = NetworkManager(type: .getTimeline, authToken: "2sTj1-s0fa37F3WBStGASg", userID: "10")
        timeline.creteTask(type: TimelineResponse.self, decoder: decoder) {
            timeCalculationForAPIResponse(index, date)
        }
    }
}

var index = 0
timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {(timer) in
    makeAPICall(index: index, user: DummyUser.current[0])
    if index == 8 {
        timer.invalidate()
    } else {
     index = index + 1
        timer.fire()
    }
})

timer?.fire()
sema.wait()
print(arr)


