//
//  AlbumsViewModel.swift
//  Bosta Task
//
//  Created by Hendawi on 02/12/2024.
//

import Combine

class AlbumsViewModel {
    @Published var albums: [Album]?
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func fetchAlbums(by userID: Int) {
        guard let url = URLBuilder.albums(by: userID) else {
            self.errorMessage = "Invalid URL"
            return
        }

        APIService.shared.fetch(from: url)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (albums: [Album]) in
                self?.albums = albums
            })
            .store(in: &cancellables)
    }
}
