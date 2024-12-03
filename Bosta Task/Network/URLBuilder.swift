//
//  Endpoints.swift
//  Bosta Task
//
//  Created by Hendawi on 02/12/2024.
//

import Foundation

struct URLBuilder {
    static let baseURL = "https://jsonplaceholder.typicode.com"

    static func endpoint(for path: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = queryItems
        return components?.url
    }
}

extension URLBuilder {
    static func user(by id: Int) -> URL? {
        return endpoint(for: "/users/\(id)")
    }
    static func albums(by userID: Int) -> URL? {
        return endpoint(for: "/users/\(userID)/albums")
    }
    static func photos(by albumID: Int) -> URL? {
        return endpoint(for: "/albums/\(albumID)/photos")
    }
}
