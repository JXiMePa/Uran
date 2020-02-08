//
//  ViewController.swift
//  uran
//
//  Created by Tarasenko Jurik on 08.02.2020.
//  Copyright © 2020 Next Level. All rights reserved.
//

import UIKit

final class PhotosViewController: UIViewController {
    
    
    //MARK: Property
    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.request(searchText: "Cat", page: 1) { (data, error) in
            print(data)
        }
    }


}

