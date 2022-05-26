//
//  APIEndpoint.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation

enum Scheme: String {
    case https = "https"
}

enum Host: String {
    case base = "api.unsplash.com"
}

enum Path: String {
    case basePath = ""
    case imageListPath = "/photos"
}

enum ClientId: String {
    case clientId = "-A0QLlKQ0W3i2sEZ5kJShnkqaQVuHRbwYDv-J9oaRvE"
}

struct APIEndpoint {
    
    static func getImageListEndpoint() -> Endpoint {
        return Endpoint(scheme: Scheme.https.rawValue, host: Host.base.rawValue, basePath: Path.basePath.rawValue, path: Path.imageListPath.rawValue, parameter: nil, queryParameters: nil, clientId: ClientId.clientId.rawValue, method: .get)
    }

}
