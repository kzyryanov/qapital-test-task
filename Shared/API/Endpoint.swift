//
//  Endpoint.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import Foundation

enum Endpoint {
    
    case activities(from: Date, to: Date)
    case user(id: Int)
    
    
    func url(scheme: String = "http", host: String) throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        
        switch self {
        case .activities(let from, let to):
            urlComponents.path = "/activities"
            urlComponents.queryItems = [
                URLQueryItem(name: "from", value: DateHelper.string(from: from)),
                URLQueryItem(name: "to", value: DateHelper.string(from: to))
            ]
        case .user(let id):
            urlComponents.path = "/users/\(id)"
        }
        guard let url = urlComponents.url else {
            throw APIServiceError.internalUrlError
        }
        return url
    }
}
