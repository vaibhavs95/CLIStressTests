//
//  APIError.swift
//  WooodStressTests
//
//  Created by Vaibhav Singh on 18/05/18.
//  Copyright © 2018 Vaibhav. All rights reserved.
//

import Foundation

//
//  APIError.swift
//  Plyreporter
//
//  Created by Koushal Sharma on 31/10/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import Alamofire

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

    static func handleURLRequestError(_ error: Error) -> APIError {
        guard let e = error as? AFError else {
            return APIError.unknown(reason: error.localizedDescription)
        }
        if e.isParameterEncodingError {
            return APIError.parameterEncodingFailed(reason: e.localizedDescription)
        } else if e.isInvalidURLError {
            return APIError.invalidURL(reason: e.localizedDescription)
        } else {
            return APIError.unknown(reason: e.localizedDescription)
        }
    }

    init(_ error: Error) {
        if let error = error as? AFError {
            if error.isInvalidURLError {
                self = APIError.invalidURL(reason: error.localizedDescription)
            } else if error.isParameterEncodingError {
                self = APIError.parameterEncodingFailed(reason: error.localizedDescription)
            } else if error.isMultipartEncodingError {
                self = APIError.multipartEncodingFailed(reason: error.localizedDescription)
            } else if error.isResponseValidationError {
                if error.responseCode == 401 {
                    self = APIError.unauthorizedUser(reason: error.localizedDescription)
                } else {
                    self = APIError.responseValidationFailed(reason: error.localizedDescription)
                }
            } else {
                self = APIError.unknown(reason: error.localizedDescription)
            }
        } else {
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
            return APIErrorStrings.invalidPath.localized()
        case .invalidURL(reason: let reason):
            return "\(APIErrorStrings.invalidURL.localized()) \(reason)"
        case .parameterEncodingFailed(let reason):
            return "\(APIErrorStrings.parameterEncoding.localized()) \(reason)"
        case .multipartEncodingFailed(reason: let reason):
            return "\(APIErrorStrings.multipleEncoding.localized()) \(reason)"
        case .responseValidationFailed(reason: let reason):
            return "\(APIErrorStrings.responseValidation.localized()) \(reason)"
        case .unauthorizedUser(reason: let reason):
            return "\(APIErrorStrings.unauthorizedUser.localized()) \(reason)"
        case .timeout:
            return APIErrorStrings.timeout.localized()
        case .internetNotReachable:
            return APIErrorStrings.internetNotReachable.localized()
        case .decodingFailed(reason: let reason):
            return "\(APIErrorStrings.decodingFailed.localized()) \(reason)"
        case .unknown(reason: let reason):
            return "\(APIErrorStrings.unknown.localized()) \(reason)"
        }
    }

    var alertTitle: String {
        switch self {
        case .invalidPath:
            return AlertTitle.invalidPath.localized()
        case .invalidURL(reason: _):
            return AlertTitle.invalidURL.localized()
        case .parameterEncodingFailed(reason: _):
            return AlertTitle.parameterEncodingFailed.localized()
        case .multipartEncodingFailed(reason: _):
            return AlertTitle.multipartEncodingFailed.localized()
        case .unauthorizedUser(reason: _):
            return AlertTitle.unauthorizedUser.localized()
        case .timeout:
            return AlertTitle.timeout.localized()
        case .internetNotReachable:
            return AlertTitle.internetNotReachable.localized()
        case .decodingFailed(reason: _):
            return AlertTitle.decodingFailed.localized()
        case .unknown, .responseValidationFailed:
            return AlertTitle.unknown.localized()
        }
    }

    var alertMessage: String {
        switch self {
        case .invalidPath:
            return AlertMessage.invalidPath.localized()
        case .invalidURL(reason: let reason):
            return reason
        case .parameterEncodingFailed(reason: let reason):
            return reason
        case .multipartEncodingFailed(reason: let reason):
            return reason
        case .responseValidationFailed:
            return AlertMessage.responseValidationFailed.localized()
        case .unauthorizedUser:
            return AlertMessage.unauthorizedUser.localized()
        case .timeout:
            return AlertMessage.timeout.localized()
        case .internetNotReachable:
            return AlertMessage.internetNotReachable.localized()
        case .decodingFailed(reason: let reason):
            return reason
        case .unknown(let reason):
            return reason
        }
    }

    var auxiliaryViewMessage: String {
        switch self {
        case .internetNotReachable:
            return AuxiliaryViewMessage.internetNotReachable.localized()
        case .unauthorizedUser, .timeout:
            return AuxiliaryViewMessage.timeout.localized()
        default:
            return AuxiliaryViewMessage.responseValidationFailed.localized()
        }
    }

    var auxiliaryViewImage: UIImage? {
        switch self {
        case .internetNotReachable:
            return UIImage(type: .networkError)
        case .unauthorizedUser, .timeout:
            return UIImage(type: .unauthorizedError)
        default:
            return UIImage(type: .error)
        }
    }
}
