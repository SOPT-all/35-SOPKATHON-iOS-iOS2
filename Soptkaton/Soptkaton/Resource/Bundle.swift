//
//  Bundle.swift
//  Soptkaton
//
//  Created by 이지훈 on 11/23/24.
//

import Foundation

extension Bundle {
    var baseURL: URL? {
        guard let path = self.path(forResource: "Info", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let baseURLString = dict["BASE_URL"] as? String else {
            return nil
        }
        return URL(string: baseURLString)
    }
}
