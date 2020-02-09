//
//  RootViewController.swift
//  uran
//
//  Created by Tarasenko Jurik on 09.02.2020.
//  Copyright © 2020 Next Level. All rights reserved.
//

import UIKit
import JGProgressHUD

class RootViewController: UIViewController {
    
    //MARK: View
    let titleLabel = UILabel()
    let hud = JGProgressHUD(style: .dark)

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    //MARK Func
    private func setupNavigationBar() {
        titleLabel.text = "PHOTOS"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        titleLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        hud.textLabel.text = "Loading"
    }

}
