//
//  Answer.swift
//  Plyreporter
//
//  Created by Vaibhav Singh on 07/11/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct Answer: Codable {

    var questionId: Int?
    var stringAnswer: String?
    var intAnswer: Int?
    var intArrayAnswer: [Int]?

    enum CodingKeys: String, CodingKey {

        case questionId = "id"
        case stringAnswer = "selections"
        case intAnswer
        case intArrayAnswer
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(questionId, forKey: CodingKeys.questionId)
        if let stringAnswer = stringAnswer {
            try container.encode(stringAnswer, forKey: CodingKeys.stringAnswer)
        } else if let intAnswer = intAnswer {
            try container.encode(intAnswer, forKey: CodingKeys.stringAnswer)
        } else if let intArrayAnswer = intArrayAnswer {
            try container.encode(intArrayAnswer, forKey: CodingKeys.stringAnswer)
        }
    }
}

struct AnswerResponse: Codable {

    var nextQuestion: Question?
    var profileCompletion: Int?

    enum CodingKeys: String, CodingKey {

        case nextQuestion = "next_question"
        case profileCompletion = "profile_completed"
    }
}
