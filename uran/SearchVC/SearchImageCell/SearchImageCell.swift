//
//  SearchImageCell.swift
//  uran
//
//  Created by Tarasenko Jurik on 08.02.2020.
//  Copyright © 2020 Next Level. All rights reserved.
//

import UIKit
import SDWebImage

protocol SearchImageCellProtocol: class {
    func deleteDidTap(_ indexPath: IndexPath)
}

final class SearchImageCell: UICollectionViewCell {
    
    //MARK: IBOutlet
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var selectHighlightedView: UIView!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    //MARK: Property
    weak var delegate: SearchImageCellProtocol?
    var indexPath: IndexPath?
    var photo: UnsplashPhoto? {
        didSet {
            if let urlString = photo?.urls[ImageSize.regular.rawValue], let url = URL(string: urlString) {
                photoImageView.sd_setImage(with: url, completed: nil)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        spiner.startAnimating()
    }
    
    override var isSelected: Bool {
        didSet {
            prepareSelectImage()
        }
    }
    
    //MARK: Func
    private func prepareSelectImage() {
        selectHighlightedView.isHidden = isSelected ? false : true
    }
    
    //MARK: Action
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        if let indexPath = self.indexPath {
            delegate?.deleteDidTap(indexPath)
        }
    }
    
}
