//
//  APIError.swift
//  WooodStressTests
//
//  Created by Vaibhav Singh on 18/05/18.
//  Copyright © 2018 Vaibhav. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidPath
    case invalidURL(reason: String)
    case parameterEncodingFailed(reason: String)
    case multipartEncodingFailed(reason: String)
    case responseValidationFailed(reason: String)
    case unauthorizedUser(reason: String)
    case timeout
    case internetNotReachable
    case unknown(reason: String)
    case decodingFailed(reason: String)

    init(_ error: Error) {
        let error = error as NSError
        if error.code == NSURLErrorUserAuthenticationRequired {
            self = APIError.unauthorizedUser(reason: error.localizedDescription)
        }else if error.code == NSURLErrorTimedOut {
            self = APIError.timeout
        } else if error.code == NSURLErrorNetworkConnectionLost || error.code == NSURLErrorNotConnectedToInternet {
            self = APIError.internetNotReachable
        } else {
            self = APIError.unknown(reason: error.localizedDescription)
        }
    }

    static func errorParsing(_ error: Error) -> APIError {
        guard let e = error as? APIError else {
            return APIError.unknown(reason: error.localizedDescription)
        }
        return e
    }
}

extension APIError {
    var description: String {
        switch self {
        case .invalidPath:
            return "Invalid Path"
        case .invalidURL(reason: let reason):
            return reason
        case .parameterEncodingFailed(let reason):
            return reason
        case .multipartEncodingFailed(reason: let reason):
            return reason
        case .responseValidationFailed(reason: let reason):
            return reason
        case .unauthorizedUser(reason: let reason):
            return reason
        case .timeout:
            return "Server Timed Out."
        case .internetNotReachable:
            return "Internet not reachable"
        case .decodingFailed(reason: let reason):
            return reason
        case .unknown(reason: let reason):
            return reason
        }
    }
}
