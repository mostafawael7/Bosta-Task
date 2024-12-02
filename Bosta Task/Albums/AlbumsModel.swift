//
//  AlbumModel.swift
//  Bosta Task
//
//  Created by Hendawi on 02/12/2024.
//

import Foundation

// MARK: - Album
struct Album: Codable {
    let userID: Int?
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id = "id"
        case title = "title"
    }
}
