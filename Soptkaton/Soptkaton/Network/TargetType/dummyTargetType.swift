//
//  HomeTargetType.swift
//  Soptkaton
//
//  Created by 이지훈 on 11/21/24.
//

import Foundation

import Moya

enum HomeTargetType {
}

extension HomeTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "YOUR_BASE_URL")!
    }
    
    var path: String {
        switch self {
        }
    }
    
    var method: Moya.Method {
        switch self {

        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
