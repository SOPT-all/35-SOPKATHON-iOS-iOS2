//
//  MeetingListService.swift
//  Soptkaton
//
//  Created by 이지훈 on 11/21/24.
//

import Foundation

import Moya

protocol HomeServiceProtocol {
    
}

class HomeService: HomeServiceProtocol {
    private let provider = MoyaProvider<HomeTargetType>(plugins: [NetworkLoggerPlugin()])
    
    func performRequest<T: Decodable>(_ target: HomeTargetType) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedResponse = try JSONDecoder().decode(T.self, from: response.data)
                        continuation.resume(returning: decodedResponse)
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
