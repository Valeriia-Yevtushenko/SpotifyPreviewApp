//
//  AppDelegate.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 15.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var rootController = UINavigationController()
    lazy var applicationCoordinator: ApplicationCoordinator = self.makeApplicationCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootController
        applicationCoordinator.start()
        window?.makeKeyAndVisible()
        return true
    }
}

private extension AppDelegate {
    func makeApplicationCoordinator() -> ApplicationCoordinator {
        let applicationCoordinator = ApplicationCoordinator(router: Router(rootController: self.rootController))
        return applicationCoordinator
    }
}
