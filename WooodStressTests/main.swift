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

/*Todo :
 1. user feed
 2. create post
 3. post detail
 4. like post
 5. comment on
 */

let url = "https://ply-reporter-dev.herokuapp.com/api/v1/timeline"

var urlRequest = URLRequest(url: URL(string: url)!)

urlRequest.allHTTPHeaderFields =  ["Authorization" : "Basic YWRtaW46ZG90c2xhc2g=",
                                   "Content-Type" : "application/json; charset=utf-8",
                                   "User-Language" : "en",
                                   "User-Id" : "10",
                                   "Authentication-Token" : "2sTj1-s0fa37F3WBStGASg" ]

func decodeResponse<T: Codable>(data: Data?, type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T? {
    do {
        if let data = data {
            let response = try decoder.decode(Response<T>.self, from: data)
            print(response.result as Any)
            return response.result
        }
    } catch let error {
        print("Error while decoding -> \(error.localizedDescription)")
    }
    return nil
}

let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
    if let err = error {
        print(err.localizedDescription)
    } else {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let timeline = try? decodeResponse(data: data, type: TimelineResponse.self, decoder: decoder)
//        do {
//            let timeline = try decoder.decode(Response<TimelineResponse>.self, from: data!).result
//            print(timeline!)
//        } catch let error {
//            print("Error while decoding -> \(error.localizedDescription)")
//        }
    }
}
dataTask.resume()



sema.wait()


