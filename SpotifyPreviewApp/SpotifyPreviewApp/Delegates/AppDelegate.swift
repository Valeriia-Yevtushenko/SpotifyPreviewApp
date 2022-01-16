//
//  AppDelegate.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 15.01.2022.
//

import UIKit
import OAuthSwift

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
    
    func application(_ app: UIApplication, open url: URL, options: [(UIApplication.OpenURLOptionsKey) : Any] = [:]) -> Bool {
        let urlHost = "oauth-callback"
        
        if url.host == urlHost {
          OAuthSwift.handle(url: url)
        }
        
        return true
    }
}

private extension AppDelegate {
    func makeApplicationCoordinator() -> ApplicationCoordinator {
        let applicationCoordinator = ApplicationCoordinator(router: Router(rootController: rootController),
                                                            serviceManager: ServiceManager(),
                                                            flowFactory: FlowFactory(),
                                                            coordinatorFactory: CoordinatorFactory())
        return applicationCoordinator
    }
}
