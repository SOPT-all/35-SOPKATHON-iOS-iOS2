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
}

// MARK: - Real Network Service
class HomeService: HomeServiceProtocol {
    private let provider = MoyaProvider<HomeTargetType>(plugins: [MoyaLoggingPlugin()])

    func fetchQuestData() async throws -> QuestResponse {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getHomeData) { result in
                switch result {
                case .success(let response):
                    do {
                        let baseResponse = try JSONDecoder().decode(BaseResponse<QuestResponse>.self, from: response.data)
                        
                        
                        guard let questData = baseResponse.data else {
                            continuation.resume(throwing: NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "데이터가 없습니다."]))
                            return
                        }
                        
                        continuation.resume(returning: questData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
