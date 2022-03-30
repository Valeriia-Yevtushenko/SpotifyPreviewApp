//
//  TabBarController.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 31.01.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().barTintColor = .secondarySystemBackground
    }
    
    func setupTabBarItems(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        viewControllers[0].tabBarItem = UITabBarItem(title: TabBarItem.search.rawValue,
                                                     image: UIImage(systemName: TabBarItem.search.imageName),
                                                     tag: TabBarItem.search.tag)
        viewControllers[1].tabBarItem = UITabBarItem(title: TabBarItem.profile.rawValue,
                                                     image: UIImage(systemName: TabBarItem.profile.imageName),
                                                     tag: TabBarItem.profile.tag)
    }
    
    func setupTabBarItems(_ viewControllers: [UIViewController], with index: Int) {
        self.viewControllers = viewControllers
        self.selectedIndex = index
        viewControllers[0].tabBarItem = UITabBarItem(title: TabBarItem.search.rawValue,
                                                     image: UIImage(systemName: TabBarItem.search.imageName),
                                                     tag: TabBarItem.search.tag)
        viewControllers[1].tabBarItem = UITabBarItem(title: TabBarItem.profile.rawValue,
                                                     image: UIImage(systemName: TabBarItem.profile.imageName),
                                                     tag: TabBarItem.profile.tag)
    }
}
