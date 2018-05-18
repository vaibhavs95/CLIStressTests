//
//  NetworkManager.swift
//  WooodStressTests
//
//  Created by Vaibhav Singh on 18/05/18.
//  Copyright © 2018 Vaibhav. All rights reserved.
//

import Foundation

class Manager {

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
}
