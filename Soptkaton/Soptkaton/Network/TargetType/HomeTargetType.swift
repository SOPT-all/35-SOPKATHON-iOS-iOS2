//
//  HomeTargetType.swift
//  Soptkaton
//
//  Created by 이지훈 on 11/21/24.
//

import Foundation

import Moya

enum HomeTargetType {
    case getHomeData
    case increaseExperience(ExperienceRequest)
}

extension HomeTargetType: TargetType {
    var baseURL: URL {
        guard let url = Bundle.main.baseURL else {
            fatalError("Invalid BASE_URL in Info.plist")
        }
        return url
    }
    
    var path: String {
            switch self {
            case .getHomeData:
                return "/api/v1/quests/home"
            case .increaseExperience:
                return "/api/v1/members/success"
            }
        }
        
        var method: Moya.Method {
            switch self {
            case .getHomeData:
                return .get
            case .increaseExperience:
                return .post
            }
        }
        
        var task: Task {
            switch self {
            case .getHomeData:
                return .requestPlain
            case .increaseExperience(let request):
                return .requestJSONEncodable(request)
            }
        }
        
        var headers: [String: String]? {
            return ["Content-Type": "application/json"]
        }
}
