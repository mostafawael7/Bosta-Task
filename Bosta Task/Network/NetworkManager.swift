//
//  NetworkManager.swift
//  Bosta Task
//
//  Created by Hendawi on 02/12/2024.
//

import Foundation
import Combine

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetch<T: Decodable>(from url: URL) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
