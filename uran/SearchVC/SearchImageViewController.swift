//
//  SearchImageViewController.swift
//  uran
//
//  Created by Tarasenko Jurik on 08.02.2020.
//  Copyright © 2020 Next Level. All rights reserved.
//

import UIKit

final class SearchImageViewController: UIViewController {
    
    //MARK: View
    private let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var doneButton: BlueButton!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    //MARK: Property
    private let imageRow: CGFloat = 3.0
    private let imageInRow: CGFloat = 3.0
    private let insert: CGFloat = 3.0
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchBar()
        setupUI()
    }
    
    //MARK: Func
    private func setupUI() {
        imageCollectionView.register(UINib(nibName: SearchImageCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchImageCell.identifier)
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "SEARCH PHOTO"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        titleLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = self.searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    //MARK: Actions
    @IBAction func doneButtonAction(_ sender: BlueButton) {
        
        //
        searchController.dismiss(animated: false, completion: nil)
        self.dismiss(animated: true, completion: nil)
        
    }
    

}

//MARK: UICollectionViewDelegate
extension SearchImageViewController: UICollectionViewDelegate {

}

//MARK: UICollectionViewDataSource
extension SearchImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: SearchImageCell.identifier, for: indexPath) as! SearchImageCell
        
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

extension SearchImageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 2 else {
            return
        }
        print(searchText)
    }
}
