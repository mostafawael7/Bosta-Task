//
//  NetworkManager.swift
//  Bosta Task
//
//  Created by Hendawi on 01/12/2024.
//

import Foundation
import Moya

enum NetworkManager: TargetType {
    case getUser(id: Int)
    case getAlbums(id: Int)
    case getPhotos(id: Int)
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .getUser(let userID):
            return "/users/\(userID)" // Retrieve User by UserID
        case .getAlbums(let userID):
            return "/albums/\(userID)" // Retrieve Albums of user by UserID
        case .getPhotos(let albumID):
            return "/photos/\(albumID)" // Retrieve Photos in Album by AlbumID
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUser, .getAlbums, .getPhotos:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getUser, .getAlbums, .getPhotos:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
