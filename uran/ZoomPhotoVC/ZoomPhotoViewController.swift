//
//  ZoomPhotoViewController.swift
//  uran
//
//  Created by Tarasenko Jurik on 08.02.2020.
//  Copyright © 2020 Next Level. All rights reserved.
//

import UIKit

final class ZoomPhotoViewController: RootViewController {
    
    //MARK: IBOutlet
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: Property
    var photo: UnsplashPhoto?
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: Func
    private func setupUI() {
        self.titleLabel.text = "PHOTO"
        backgroundScrollView.delegate = self
        if let urlString = photo?.urls[ImageSize.regular.rawValue],
            let url = URL(string: urlString) {
            photoImageView.sd_setImage(with: url, completed: nil)
        }
    }
}

//MARK: UIScrollViewDelegate
extension ZoomPhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
}
