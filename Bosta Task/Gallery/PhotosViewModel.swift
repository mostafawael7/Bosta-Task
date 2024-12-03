//
//  PhotosViewModel.swift
//  Bosta Task
//
//  Created by Hendawi on 03/12/2024.
//

import Combine

class PhotosViewModel {
    @Published var photos: [Photo]?
    @Published var filteredPhotos: [Photo]?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPhotos(by albumID: Int) {
        guard let url = URLBuilder.photos(by: albumID) else {
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
            }, receiveValue: { [weak self] (photos: [Photo]) in
                self?.photos = photos
                self?.filteredPhotos = photos
            })
            .store(in: &cancellables)
    }
    
    func filterPhotos(by title: String) {
        guard let photos = photos else { return }
        if title.isEmpty {
            self.filteredPhotos = photos
        } else {
            self.filteredPhotos = photos.filter { $0.title!.lowercased().contains(title.lowercased()) }
        }
    }
}
