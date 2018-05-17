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

let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
    if let err = error {
        print(err.localizedDescription)
    } else {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        do {
            let timeline = try decoder.decode(Response<TimelineResponse>.self, from: data!).result
            print(timeline!)
        } catch let error {
            print("Error while decoding -> \(error.localizedDescription)")
        }
    }
}
dataTask.resume()

extension Date {
    static func dateFormatter(_ format: DateFormat = .api) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = TimeZone.current

        return dateFormatter
    }
}

enum DateFormat: String {
    case api = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case review = "MMM yyyy"
    case news = "dd MMM yyyy"
}

sema.wait()


