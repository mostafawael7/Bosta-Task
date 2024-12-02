//
//  NetworkManager.swift
//  Bosta Task
//
//  Created by Hendawi on 01/12/2024.
//

import Foundation
import Moya

//enum UserAPI {
//    case getUser(userId: Int)
//}
//
//extension UserAPI: TargetType {
//    var baseURL: URL {
//        return URL(string: "https://jsonplaceholder.typicode.com")!
//    }
//
//    var path: String {
//        switch self {
//        case .getUser(let userId):
//            return "/users/\(userId)"
//        }
//    }
//
//    var method: Moya.Method {
//        return .get
//    }
//
//    var task: Moya.Task {
//        return .requestPlain
//    }
//
//    var headers: [String: String]? {
//        return nil
//    }
//}


//enum AlbumAPI: TargetType {
//    case getAlbums(userID: Int)
//
//    var baseURL: URL {
//        return URL(string: "https://jsonplaceholder.typicode.com")!
//    }
//
//    var path: String {
//        switch self {
//        case .getAlbums(let userID):
//            return "/albums?userId=\(userID)"
//        }
//    }
//
//    var method: Moya.Method {
//        return .get
//    }
//
//    var task: Task {
//        return .requestPlain
//    }
//
//    var headers: [String: String]? {
//        return ["Content-Type": "application/json"]
//    }
//}
//
//enum PhotoAPI: TargetType {
//    case getPhotos(albumID: Int)
//
//    var baseURL: URL {
//        return URL(string: "https://jsonplaceholder.typicode.com")!
//    }
//
//    var path: String {
//        switch self {
//        case .getPhotos(let albumID):
//            return "/photos?albumId=\(albumID)"
//        }
//    }
//
//    var method: Moya.Method {
//        return .get
//    }
//
//    var task: Task {
//        return .requestPlain
//    }
//
//    var headers: [String: String]? {
//        return ["Content-Type": "application/json"]
//    }
//}
