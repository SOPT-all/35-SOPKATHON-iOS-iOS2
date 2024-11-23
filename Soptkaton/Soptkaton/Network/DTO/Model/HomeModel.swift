//
//  HomeModel.swift
//  Soptkaton
//
//  Created by 이지훈 on 11/24/24.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let data: T?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case data
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container.decodeIfPresent(T.self, forKey: .data)
        self.message = try? container.decodeIfPresent(String.self, forKey: .message)
    }
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
