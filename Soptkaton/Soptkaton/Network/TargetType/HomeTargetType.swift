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
    case postMemberSuccess
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
        case .postMemberSuccess:
            return "/api/v1/members/success"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHomeData:
            return .get
        case .postMemberSuccess:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getHomeData:
            return .requestPlain
        case .postMemberSuccess:
            // TODO:  만약 POST 요청에 body가 필요하다면 아래와 같이 파라미터를 추가
            // return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
