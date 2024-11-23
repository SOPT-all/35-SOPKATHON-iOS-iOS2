//
//  MeetingListService.swift
//  Soptkaton
//
//  Created by 이지훈 on 11/21/24.
//

import Foundation
import Moya

protocol HomeServiceProtocol {
    func fetchQuestData() async throws -> QuestResponse
    func increaseExperience() async throws -> ExperienceResponse
}

class HomeService: HomeServiceProtocol {
    private let provider = MoyaProvider<HomeTargetType>(plugins: [MoyaLoggingPlugin()])
    
    func fetchQuestData() async throws -> QuestResponse {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getHomeData) { result in
                switch result {
                case .success(let response):
                    do {
                        let baseResponse = try JSONDecoder().decode(BaseResponse<QuestResponse>.self, from: response.data)
                        continuation.resume(returning: baseResponse.data)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func increaseExperience() async throws -> ExperienceResponse {
        return try await withCheckedThrowingContinuation { continuation in
            let request = ExperienceRequest(quest_exp: 35)
            
            provider.request(.increaseExperience(request)) { result in
                switch result {
                case .success(let response):
                    do {
                        let experienceResponse = try JSONDecoder().decode(ExperienceResponse.self, from: response.data)
                        continuation.resume(returning: experienceResponse)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(_):
                    let errorResponse = ExperienceResponse(
                        success: false,
                        message: "서버 내부 오류입니다."
                    )
                    continuation.resume(returning: errorResponse)
                }
            }
        }
    }
}
