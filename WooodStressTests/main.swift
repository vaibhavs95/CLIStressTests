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

var arr: [TimeCalcultion] = [TimeCalcultion](repeating: TimeCalcultion(), count: 8)
var timer: Timer?
var resonses: [Int] = [Int](repeating: DummyUser.current.count, count: 8)

func timeCalculationForAPIResponse(_ index: Int, _ time: Double) {
    arr[index].min =  arr[index].min < time ? arr[index].min : time
    arr[index].max = arr[index].max > time ? arr[index].max : time
    arr[index].average =  (arr[index].average * Double(arr[index].totalResponse) + time) / Double(arr[index].totalResponse + 1)
    arr[index].totalResponse = arr[index].totalResponse + 1
    printTimeArray()
}

func printTimeArray() {
    let totalResponses = arr.map{$0.totalResponse}
    if totalResponses == resonses {
        print(arr)
        sema.signal()
    }
}

func apiResonseTiming (_ index: Int, _ success: Bool, _ time: Double) {
    if success {
        timeCalculationForAPIResponse(index, time)
    } else {
        resonses[index] -= 1
        printTimeArray()
    }
}

func makeAPICall(index: Int, user: DummyUser) {
    let date = Date()
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
    decoder.dateDecodingStrategy = .formatted(dateFormatter)

    switch index {
    case 0:
        let timeline = NetworkManager(type: .getTimeline, authToken: user.authToken, userID: user.userId)
        timeline.creteTask(type: TimelineResponse.self, decoder: decoder) { success in
            print("Get Timeline")
            apiResonseTiming(index, success, -date.timeIntervalSinceNow)
        }
    case 1:
        let getUserFeed = NetworkManager(type: .getUserFeed(id: 10), authToken: user.authToken, userID: user.userId)
        getUserFeed.creteTask(type: TimelineResponse.self, decoder: decoder) { success in
            print("Get User Feed")
            apiResonseTiming(index, success, -date.timeIntervalSinceNow)
        }
    case 2:
        let post = Post(postId: nil, commentText: nil, content: "Create new post for testing server response", attachment: nil, author: nil)
        let createPost = NetworkManager(type: .createPost(post: post), authToken: user.authToken, userID: user.userId)
        createPost.creteTask(type: CreatePostReponse.self, decoder: decoder) { success in
            print("Create post")
            apiResonseTiming(index, success, -date.timeIntervalSinceNow)
        }
    case 3:
        let postDetail = NetworkManager(type: .getPostDetail(id: 806), authToken: user.authToken, userID: user.userId)
        postDetail.creteTask(type: PostDetail.self, decoder: decoder) { success in
            print("Get Post Detail")
            apiResonseTiming(index, success, -date.timeIntervalSinceNow)
        }
    case 4:
        let likePost = NetworkManager(type: .likePost(post: Post(postId: 806, commentText: nil, content: nil, attachment: nil, author: nil)), authToken: user.authToken, userID: user.userId)
        likePost.creteTask(type: TimelineResponse.self, decoder: decoder) { success in
            print("Like Post")
            apiResonseTiming(index, success, -date.timeIntervalSinceNow)
        }
    case 5:
        let post = Post(postId: 806, commentText: "This is a comment", content: nil, attachment: nil, author: nil)
        let commentOnPost = NetworkManager(type: .comment(post: post), authToken: user.authToken, userID: user.userId)
        commentOnPost.creteTask(type: CommentResult.self, decoder: decoder) { success in
            print("Comment Post")
            apiResonseTiming(index, success, -date.timeIntervalSinceNow)
        }
    case 6:
        let comments = NetworkManager(type: .getAllComments(postId: 806), authToken: user.authToken, userID: user.userId)
        comments.creteTask(type: PostCommentsResponse.self, decoder: decoder) { success in
            print("Get Comments")
            apiResonseTiming(index, success, -date.timeIntervalSinceNow)
        }
    case 7:
        let likes = NetworkManager(type: .getAllLikes(postId: 806), authToken: user.authToken, userID: user.userId)
        likes.creteTask(type: PostLikes.self, decoder: decoder) { success in
            print("Get All Likes")
            apiResonseTiming(index, success, -date.timeIntervalSinceNow)
            //            index = DummyUser.current.count
        }
    //    case 8: //TODO: delete
    default:
        let timeline = NetworkManager(type: .getTimeline, authToken: user.authToken, userID: user.userId)
        timeline.creteTask(type: TimelineResponse.self, decoder: decoder) { success in
            apiResonseTiming(index, success, -date.timeIntervalSinceNow)
        }
    }
}

func APIcalling(user: DummyUser) {
    var index = 0
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {(timer) in
        makeAPICall(index: index, user: user)
        if index == 7 {
            timer.invalidate()
        } else {
            index = index + 1
            timer.fire()
        }
    })

    timer?.fire()
}

for (index, user) in DummyUser.current.enumerated() {
    print("Calling for user : \(index)")
    APIcalling(user: user)
}
sema.wait()
