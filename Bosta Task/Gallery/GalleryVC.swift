//
//  GalleryVC.swift
//  Bosta Task
//
//  Created by Hendawi on 03/12/2024.
//

import UIKit
import Kingfisher
import Combine

class GalleryVC: UIViewController {
    private let viewModel = PhotosViewModel()
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet weak private var albumLbl: UILabel!
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var collectionView: UICollectionView!
    
    var albumTitle = ""
    var albumID = 0
    private let cellID = "PhotosCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumLbl.text = albumTitle
        initSearchBar()
        initCollectionView()
        bindViewModel()
        viewModel.fetchPhotos(by: albumID)
    }
    
    private func initSearchBar(){
        searchBar.delegate = self
        
        //Add Toolbar to dismiss keyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([doneButton], animated: false)
        
        searchBar.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    private func initCollectionView(){
        let itemCount = 3
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let totalSpacing: CGFloat = 1 * CGFloat(itemCount - 1)
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / CGFloat(itemCount)
        
        layout.itemSize = CGSize(width: itemWidth, height: CGFloat(itemWidth))
        layout.minimumInteritemSpacing = 0
        
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    
    private func bindViewModel() {
        viewModel.$photos
            .sink { [weak self] photos in
                DispatchQueue.main.async{
                    self?.collectionView.reloadData()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .sink { errorMessage in
                if let errorMessage = errorMessage {
                    print("Photos Error: \(errorMessage)")
                }
            }
            .store(in: &cancellables)
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension GalleryVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterPhotos(by: searchText)
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
    }
}

extension GalleryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PhotosCollectionViewCell
        if let thumbnail = viewModel.filteredPhotos?[indexPath.row].url {
            let url = URL(string: thumbnail)
            cell.imgView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder")) { result in
                switch result{
                case .success:
                    self.viewModel.filteredPhotos?[indexPath.row].isLoaded = true
                case .failure:
                    break
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let str = viewModel.filteredPhotos?[indexPath.row].url,
           let imageUrl = URL(string: str), viewModel.filteredPhotos?[indexPath.row].isLoaded == true {
            let dest = self.storyboard?.instantiateViewController(withIdentifier: "PhotoViewerVC") as! PhotoViewerVC
            dest.modalPresentationStyle = .fullScreen
            dest.imageURL = imageUrl
            present(dest, animated: true)
        }else{
            displayAlert(title: "Error", message: "Photo didn't load yet")
        }
    }
}
