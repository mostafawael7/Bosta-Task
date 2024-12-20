//
//  UserViewModel.swift
//  Bosta Task
//
//  Created by Hendawi on 01/12/2024.
//

import Combine

class UserViewModel {
    @Published var user: User?
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func fetchUser(by id: Int) {
        guard let url = URLBuilder.user(by: id) else {
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
            }, receiveValue: { [weak self] (user: User) in
                self?.user = user
            })
            .store(in: &cancellables)
    }
}
