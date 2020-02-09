//
//  ImageCell.swift
//  uran
//
//  Created by Tarasenko Jurik on 08.02.2020.
//  Copyright © 2020 Next Level. All rights reserved.
//

import UIKit

final class ImageCell: UICollectionViewCell {

    //MARK: IBOutlet
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: Property
    var photo: UnsplashPhoto? {
        didSet {
            if let urlString = photo?.urls[ImageSize.regular.rawValue], let url = URL(string: urlString) {
                photoImageView.sd_setImage(with: url, completed: nil)
            }
        }
    }
    

}
