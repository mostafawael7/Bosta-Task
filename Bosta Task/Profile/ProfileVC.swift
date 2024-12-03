//
//  ProfileVC.swift
//  Bosta Task
//
//  Created by Hendawi on 02/12/2024.
//

import UIKit
import Combine

class ProfileVC: UIViewController {
    private let userViewModel = UserViewModel()
    private let albumsViewModel = AlbumsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private let cellID = "AlbumsTableViewCell"
    
    var randomID = Int.random(in: 1...10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        bindViewModels()
        userViewModel.fetchUser(by: randomID)
        albumsViewModel.fetchAlbums(by: randomID)
    }
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    private func bindViewModels() {
        userViewModel.$user
            .sink { [weak self] user in
                guard let user = user else { return }
                self?.updateUI(user: user)
            }
            .store(in: &cancellables)
        
        userViewModel.$errorMessage
            .sink { errorMessage in
                if let errorMessage = errorMessage {
                    print("User Error: \(errorMessage)")
                }
            }
            .store(in: &cancellables)
        
        albumsViewModel.$albums
            .sink { [weak self] albums in
                DispatchQueue.main.async{
//                    self?.hideAnimatedActivityIndicatorView()
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
        
        albumsViewModel.$errorMessage
            .sink { errorMessage in
                if let errorMessage = errorMessage {
                    print("Albums Error: \(errorMessage)")
                }
            }
            .store(in: &cancellables)
    }
    
    private func updateUI(user: User){
        nameLbl.text = user.name ?? "-"
        addressLbl.text = "\(user.address?.getFullAddress() ?? "-")"
//        hideAnimatedActivityIndicatorView()
    }
    @IBAction func refreshBtnClicked(_ sender: UIButton) {
        randomID = Int.random(in: 1...10)
        userViewModel.fetchUser(by: randomID)
        albumsViewModel.fetchAlbums(by: randomID)
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Albums"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsViewModel.albums?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AlbumsTableViewCell
        cell.nameLbl.text = albumsViewModel.albums?[indexPath.row].title ?? "-"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "GalleryVC") as! GalleryVC
        dest.albumTitle = (albumsViewModel.albums?[indexPath.row].title)!
        dest.albumID = (albumsViewModel.albums?[indexPath.row].id)!
        dest.modalPresentationStyle = .fullScreen
        self.present(dest, animated: true)
    }
}
