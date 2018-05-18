//
//  Question.swift
//  Plyreporter
//
//  Created by Vaibhav Singh on 07/11/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct Question: Codable {

    var id: Int?
    var questionText: String?
    var hint: String?
    var questionType: QuestionType?
    var options: [Option]?
    var profileCompletion: Int?

    enum CodingKeys: String, CodingKey {

        case id
        case questionText = "text"
        case hint
        case questionType = "type"
        case options
        case profileCompletion = "profile_completed"
    }
}

struct Option: Codable {

    var id: Int?
    var value: String?

    enum CodingKeys: String, CodingKey {
        case id
        case value
    }
}

enum QuestionType: String, Codable {

    case singleChoice = "single_choice"
    case multipleChoice = "multiple_choice"
    case singleLine = "single_line"
    case paragraph
    case number
    case image
}
