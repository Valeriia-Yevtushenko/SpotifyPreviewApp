//
//  TabBarController.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 31.01.2022.
//

import UIKit

protocol TabBarViewControllerDelegate: AnyObject {
    func setupTabBarItems(_ viewControllers: [UIViewController])
    func setupTabBarItems(_ viewControllers: [UIViewController], with index: Int)
}

final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TabBarViewController: TabBarViewControllerDelegate {
    func setupTabBarItems(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        viewControllers[0].tabBarItem = UITabBarItem(title: TabBarItem.search.rawValue,
                                                     image: UIImage(systemName: TabBarItem.search.imageName),
                                                     tag: TabBarItem.search.tag)
    }
    
    func setupTabBarItems(_ viewControllers: [UIViewController], with index: Int) {
        self.viewControllers = viewControllers
        self.selectedIndex = index
        viewControllers[0].tabBarItem = UITabBarItem(title: TabBarItem.search.rawValue,
                                                     image: UIImage(systemName: TabBarItem.search.imageName),
                                                     tag: TabBarItem.search.tag)
    }
}
