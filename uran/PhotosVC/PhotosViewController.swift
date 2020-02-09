//
//  ViewController.swift
//  uran
//
//  Created by Tarasenko Jurik on 08.02.2020.
//  Copyright © 2020 Next Level. All rights reserved.
//

import UIKit
import DeckTransition

final class PhotosViewController: RootViewController {
    
    //MARK: IBOutlet
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    //MARK: Property
    private let imageRow: CGFloat = 3.0
    private let imageInRow: CGFloat = 3.0
    private let insert: CGFloat = 3.0
    private var photos = [UnsplashPhoto]()

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: Func
   private func setupUI() {
    imageCollectionView.register(UINib(nibName: ImageCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageCell.identifier)
    }
    
    //MARK: Actions
    @IBAction func searchButtonAction(_ sender: UIButton) {
        let searchNavVC = SearchNavigationViewController.instance(.search)
        let transitionDelegate = DeckTransitioningDelegate()
        searchNavVC.transitioningDelegate = transitionDelegate
        searchNavVC.modalPresentationStyle = .custom
        if let searchVC = searchNavVC.viewControllers.first as? SearchImageViewController {
            searchVC.delegate = self
            present(searchNavVC, animated: true, completion: nil)
        }
        
    }

}

//MARK: UICollectionViewDelegate
extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let zoomImageVC = ZoomPhotoViewController.instance()
        zoomImageVC.photo = photos[indexPath.item]
        navigationController?.pushViewController(zoomImageVC, animated: true)
    }
}

//MARK: UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        placeholderLabel.isHidden = photos.count > 0
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.photo = photos[indexPath.item]
        return cell
    }

}

//MARK: UICollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (imageCollectionView.frame.width - insert * imageInRow) / imageInRow
        let height: CGFloat = imageCollectionView.frame.height / imageRow
    
        return CGSize(width: width, height: height)
    }
}

//MARK: SearchImageProtocol
extension PhotosViewController: SearchImageProtocol {
    func photoIsSelected(_ photo: [UnsplashPhoto]) {
        self.photos += photo
        self.imageCollectionView.reloadData()
    }
    
    
}
