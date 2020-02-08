//
//  UIViewController.swift
//  uran
//
//  Created by Tarasenko Jurik on 08.02.2020.
//  Copyright © 2020 Next Level. All rights reserved.
//

import UIKit

//MARK: NSObject
extension NSObject {
    class var identifier: String {
        return String(describing: self)
    }
}

//MARK: UIViewController & UIStoryboard
enum Storyboards: String {
    case main = "Main"
    case search = "SearchImages"
}

extension UIViewController {
    class func instance(_ storyboard: Storyboards = .main) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(self)
        return viewController
    }
}

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(_ type: T.Type) -> T {
        let id = NSStringFromClass(T.self).components(separatedBy: ".").last!
        return self.instantiateViewController(withIdentifier: id) as! T
    }
}
