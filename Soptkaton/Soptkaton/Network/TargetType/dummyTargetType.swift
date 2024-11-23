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
        guard let url = Bundle.main.baseURL else {
            fatalError("Invalid BASE_URL in Info.plist")
        }
        return url
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
