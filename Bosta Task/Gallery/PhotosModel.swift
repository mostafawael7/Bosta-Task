//
//  PhotosModel.swift
//  Bosta Task
//
//  Created by Hendawi on 03/12/2024.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let albumID: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailURL: String?
    var isLoaded: Bool?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailURL = "thumbnailUrl"
    }
}
