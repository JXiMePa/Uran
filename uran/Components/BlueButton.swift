//
//  BlueButton.swift
//  uran
//
//  Created by Tarasenko Jurik on 08.02.2020.
//  Copyright © 2020 Next Level. All rights reserved.
//

import UIKit

class BlueButton: UIButton {

    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultSetup()
    }
    
    //MARK: Func
    private func defaultSetup() {
        setTitleColor(UIColor.black, for: .normal)
        backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        cornerRadius = 3.0
        shadowRadius = 10.0
        shadowColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 0.5)
        shadowOpacity = 1
        shadowOffset = CGSize(width: 0, height: 8)
        self.titleLabel?.font =  UIFont(name: "Avenir-Black", size: 24)
    }
}
