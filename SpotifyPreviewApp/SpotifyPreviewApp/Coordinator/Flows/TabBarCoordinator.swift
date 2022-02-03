//
//  TabBarCoordinator.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 01.02.2022.
//

import UIKit

protocol TabbarCoordinatorOutput: AnyObject {
    func finishTabBarFlow(coordinator: Coordinator)
}

class TabBarCoordinator: BaseCoordinator {
    private weak var tabBarViewControllerDelegat: TabBarViewControllerDelegate?
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let flowFactory: FlowFactory
    private let serviceManager: ServiceManagerProtocol
    weak var output: TabbarCoordinatorOutput?
    
    init(tabBarViewControllerDelegat: TabBarViewControllerDelegate, coordinatorFactory: CoordinatorFactoryProtocol, serviceManager: ServiceManagerProtocol, flowFactory: FlowFactory) {
        self.tabBarViewControllerDelegat = tabBarViewControllerDelegat
        self.coordinatorFactory = coordinatorFactory
        self.serviceManager = serviceManager
        self.flowFactory = flowFactory
    }
    
    override func start() {
        setupTabBarController()
    }
}

private extension TabBarCoordinator {
    func setupTabBarController() {
        let searchController = searchFlow()
        let profileController = profileFlow()
        tabBarViewControllerDelegat?.setupTabBarItems([searchController, profileController])
    }
    
    func searchFlow() -> UINavigationController {
        let navigationController = UINavigationController()
        let searchCoordinator = coordinatorFactory.makeSearchCoordinator(factory: flowFactory,
                                                                            router: Router(rootController: navigationController),
                                                                            serviceManager: serviceManager)
        searchCoordinator.output = self
        searchCoordinator.start()
        addDependency(searchCoordinator)
        return navigationController
    }
    
    func profileFlow() -> UINavigationController {
        let navigationController = UINavigationController()
        let profileCoordinator = coordinatorFactory.makeProfileCoordinator(factory: flowFactory,
                                                                              router: Router(rootController: navigationController),
                                                                           serviceManager: serviceManager)
        profileCoordinator.output = self
        profileCoordinator.start()
        addDependency(profileCoordinator)
        return navigationController
    }
}

extension TabBarCoordinator: SearchCoordinatorOutput {
    func finishSearchFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}

extension TabBarCoordinator: ProfileCoordinatorOutput {
    func finishProfileFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
        output?.finishTabBarFlow(coordinator: self)
    }
}
