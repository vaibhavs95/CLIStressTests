//
//  Response.swift
//  Plyreporter
//
//  Created by Koushal Sharma on 01/11/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct Response<T>: Codable where T: Codable {
    
    var success: Bool?
    var error: String?
    var result: T?
    
    enum CodingKeys: String, CodingKey {
        
        case success
        case error
        case result
    }
}
