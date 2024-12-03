//
//  PhotoViewerVC.swift
//  Bosta Task
//
//  Created by Hendawi on 03/12/2024.
//

import UIKit
import Kingfisher

class PhotoViewerVC: UIViewController, UIScrollViewDelegate {
    var imageURL: URL!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.kf.setImage(with: imageURL)
        scrollView.delegate = self
        
        scrollView.contentSize = imageView.frame.size
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
