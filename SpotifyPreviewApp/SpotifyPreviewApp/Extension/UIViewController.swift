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
