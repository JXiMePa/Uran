//
//  ViewController.swift
//  uran
//
//  Created by Tarasenko Jurik on 08.02.2020.
//  Copyright © 2020 Next Level. All rights reserved.
//

import UIKit
import DeckTransition

final class PhotosViewController: UIViewController {
    
    //MARK: IBOutlet
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var searchButton: UIButton!
    
    //MARK: Property
    private let imageRow: CGFloat = 3.0
    private let imageInRow: CGFloat = 3.0
    private let insert: CGFloat = 3.0

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()

    }
    
    //MARK: Func
   private func setupUI() {
    imageCollectionView.register(UINib(nibName: ImageCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageCell.identifier)
    }
    private func setupNavigationBar() {
           let titleLabel = UILabel()
           titleLabel.text = "PHOTOS"
           titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
           titleLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
           navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
       }
    
    //MARK: Actions
    @IBAction func searchButtonAction(_ sender: UIButton) {
        let searchNavVC = SearchNavigationViewController.instance(.search)
        let transitionDelegate = DeckTransitioningDelegate()
        searchNavVC.transitioningDelegate = transitionDelegate
        searchNavVC.modalPresentationStyle = .custom
        if let searchVC = searchNavVC.viewControllers.first as? SearchImageViewController {
            present(searchNavVC, animated: true, completion: nil)
        }
        
    }

}

//MARK: UICollectionViewDelegate
extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let zoomImageVC = ZoomPhotoViewController.instance() 
        navigationController?.pushViewController(zoomImageVC, animated: true)
    }
}

//MARK: UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        
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
