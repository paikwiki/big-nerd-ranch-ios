//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by Changhyun Baek on 2020/05/30.
//  Copyright © 2020 paikwiki. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    func update(displaying image: UIImage?) {
        if let imageTodisplay = image {
            spinner.stopAnimating()
            imageView.image = imageTodisplay
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
}
