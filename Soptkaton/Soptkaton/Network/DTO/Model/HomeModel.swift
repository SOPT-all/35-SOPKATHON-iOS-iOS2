//
//  HomeModel.swift
//  Soptkaton
//
//  Created by 이지훈 on 11/24/24.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let success: Bool
    let message: String
    let data: T
}

struct QuestResponse: Decodable {
    let member_level: String
    let member_exp: String
    let member_img_url: String
    let quest_name: String
    let quest_summary: String
    let quest_level: String
    let quest_exp: Int
    let quest_description: String
}

struct ExperienceRequest: Codable {
    let quest_exp: Int
}

struct ExperienceResponse: Codable {
    let success: Bool
    let message: String
}
