//
//  AppConfig.swift
//  Plyreporter
//
//  Created by Sunita Moond on 06/02/18.
//  Copyright © 2018 moldedbits. All rights reserved.
//

import Foundation

struct AppConfig: Codable {

    var states: [FilterCategory]
    var businessProfile: [FilterCategory]

    enum CodingKeys: String, CodingKey {

        case states
        case businessProfile = "business_profiles"
    }
}

struct CityResult: Codable {

    var cities: [FilterCategory]

    enum CodingKeys: String, CodingKey {

        case cities
    }
}

struct AppConfigResult: Codable {

    var config: AppConfig

    enum CodingKeys: String, CodingKey {

        case config
    }
}
