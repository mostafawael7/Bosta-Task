//
//  PhotosCollectionViewCell.swift
//  Bosta Task
//
//  Created by Hendawi on 03/12/2024.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        imgView.image = UIImage(named: "placeholder")
    }
}
