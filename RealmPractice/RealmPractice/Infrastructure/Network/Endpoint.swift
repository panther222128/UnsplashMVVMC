//
//  File.swift
//  RealmPractice
//
//  Created by Jun Ho JANG on 2022/05/24.
//

import Foundation

protocol Requestable {
    var scheme: String { get }
    var host: String { get }
    var basePath: String { get }
    var path: String { get }
    var parameter: Int? { get }
    var queryParameters: [String: Any]? { get }
    var clientId: String? { get }
    var method: HTTPMethod { get }
    
    func url() -> URL?
}

enum HTTPMethod: String {
    case get = "GET"
}

struct Endpoint: Requestable {
    
    let scheme: String
    let host: String
    let basePath: String
    let path: String
    let parameter: Int?
    let queryParameters: [String: Any]?
    let clientId: String?
    let method: HTTPMethod

    init(scheme: String, host: String, basePath: String, path: String, parameter: Int?, queryParameters: [String: Any]?, clientId: String?, method: HTTPMethod) {
        self.scheme = scheme
        self.host = host
        self.basePath = basePath
        self.path = path
        self.parameter = parameter
        self.clientId = clientId
        self.queryParameters = queryParameters
        self.method = method
    }
    
    func url() -> URL? {
        var component = URLComponents()
        component.scheme = self.scheme
        component.host = self.host
        var queryItems = [URLQueryItem]()
        component.path = self.basePath + self.path
        if let clientId = clientId {
            queryItems.append(URLQueryItem(name: "client_id", value: clientId))
        }
        component.queryItems = queryItems
        return component.url
    }
    
}
