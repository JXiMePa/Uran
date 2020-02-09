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

//MARK: UIViewController
extension UIViewController {
    class func instance(_ storyboard: Storyboards = .main) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(self)
        return viewController
    }
    
    func showAlert(title: String, msg: String, customActions: [UIAlertAction] = []) {
          DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
              
              if customActions.isEmpty {
                  alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
              } else {
                  for action in customActions {
                      alert.addAction(action)
                  }
              }
              self.present(alert, animated: true, completion: nil)
          }
      }
}

//MARK: UIStoryboard
extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(_ type: T.Type) -> T {
        let id = NSStringFromClass(T.self).components(separatedBy: ".").last!
        return self.instantiateViewController(withIdentifier: id) as! T
    }
}
