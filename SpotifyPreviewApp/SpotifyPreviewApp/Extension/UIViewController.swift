//
//  ViewController.swift
//  LocationApp
//
//  Created by Yevtushenko Valeriia on 30.06.2021.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardInstantiable {}

extension UIViewController: Presentable {
    
    func toPresent() -> UIViewController? {
        return self
    }
}

extension UIViewController {
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
}
