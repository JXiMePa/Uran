//
//  SearchImageViewController.swift
//  uran
//
//  Created by Tarasenko Jurik on 08.02.2020.
//  Copyright © 2020 Next Level. All rights reserved.
//

import UIKit

protocol SearchImageProtocol: class {
    func photoIsSelected(_ photo: [UnsplashPhoto])
}

final class SearchImageViewController: RootViewController {
    
    //MARK: View
    private let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var doneButton: BlueButton!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    //MARK: Property
    private let imageRow: CGFloat = 3.0
    private let imageInRow: CGFloat = 3.0
    private let insert: CGFloat = 3.0
    private var timer: Timer?
    private let networkDataFetcher = NetworkDataFetcher()
    private var page = 1
    private var searchText = ""
    private var photos = [UnsplashPhoto]()
    private var selectedIndexPath = [IndexPath]()
    weak var delegate: SearchImageProtocol?
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupUI()
        checkInternet()
    }
    
    //MARK: Func
    private func setupUI() {
        self.titleLabel.text = "SEARCH PHOTO"
        imageCollectionView.register(UINib(nibName: SearchImageCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchImageCell.identifier)
        imageCollectionView.allowsMultipleSelection = true
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = self.searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func checkInternet() {
        if !Reachability.isConnectedToNetwork() {
            self.showAlert(title: "Internet? 😓", msg: "Connection not Available!")
        }
    }
    
    //MARK: Actions
    @IBAction func doneButtonAction(_ sender: BlueButton) {
        var selectedPhoto = [UnsplashPhoto]()
        for indexPath in selectedIndexPath {
            selectedPhoto.append(photos[indexPath.item])
        }
        delegate?.photoIsSelected(selectedPhoto)
        searchController.dismiss(animated: false, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }

}

//MARK: UICollectionViewDelegate
extension SearchImageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath.append(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let index = selectedIndexPath.firstIndex(of: indexPath) {
            selectedIndexPath.remove(at: index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == photos.count - 1 {
            hud.show(in: self.view)
            networkDataFetcher.fetchImages(searchText: searchText, page: page + 1) { [weak self] (searchResult) in
                guard let `self` = self else { return }
                self.hud.dismiss()
                if let models = searchResult?.results {
                    self.photos += models
                    self.page += 1
                    self.imageCollectionView.reloadData()
                }
            }
        }
    }
}

//MARK: UICollectionViewDataSource
extension SearchImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: SearchImageCell.identifier, for: indexPath) as! SearchImageCell
        cell.indexPath = indexPath
        cell.delegate = self
        cell.photo = photos[indexPath.item]
        if let _ = selectedIndexPath.firstIndex(of: indexPath) {
            cell.isSelected = true
        }
        return cell
    }
    
}

//MARK: UICollectionViewDelegateFlowLayout
extension SearchImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (imageCollectionView.frame.width - insert * imageInRow) / imageInRow
        let height: CGFloat = imageCollectionView.frame.height / imageRow
        
        return CGSize(width: width, height: height)
    }
}

//MARK: UISearchBarDelegate
extension SearchImageViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 2 else {
            return
        }
        self.searchText = searchText
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (_) in
            guard let `self` = self else { return }
            self.hud.show(in: self.view)
            self.networkDataFetcher.fetchImages(searchText: searchText, page: 1) { [weak self] (searchResult) in
                guard let `self` = self else { return }
                self.hud.dismiss()
                if let models = searchResult?.results {
                    self.photos = models
                    self.imageCollectionView.reloadData()
                }
            }
        })
    }
}

//MARK: SearchImageCellProtocol
extension SearchImageViewController: SearchImageCellProtocol {
    
    func deleteDidTap(_ indexPath: IndexPath) {
        photos.remove(at: indexPath.item)
        if let index = selectedIndexPath.firstIndex(of: indexPath) {
            selectedIndexPath.remove(at: index)
        }
        imageCollectionView.reloadData()
    }
}
