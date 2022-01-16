//
//  StoryboardInstantiable.swift
//  LocationApp
//
//  Created by Yevtushenko Valeriia on 30.06.2021.
//

import UIKit

protocol StoryboardInstantiable: AnyObject {}

extension StoryboardInstantiable {
    static func instantiate(from storyboard: String, bundle: Bundle? = nil) -> Self where Self: UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: bundle)
        let identifier = String(describing: self)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "\(identifier)") as? Self else {
            fatalError("Could not instantiate view controller with identifier \(identifier)")
        }
        
        return viewController
    }
}
