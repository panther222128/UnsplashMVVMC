//
//  APIEndpointForMoya.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/25.
//

import Foundation
import Moya

enum ImageListEndpoint {
    case imageSourcePath
}

extension ImageListEndpoint: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.unsplash.com")!
    }
    
    var path: String {
        switch self {
        case .imageSourcePath:
            return "/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .imageSourcePath:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .imageSourcePath:
            return .requestParameters(parameters: ["client_id": "-A0QLlKQ0W3i2sEZ5kJShnkqaQVuHRbwYDv-J9oaRvE"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}



