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
        let firstController = searchFlow()
        tabBarViewControllerDelegat?.setupTabBarItems([firstController])
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
}

extension TabBarCoordinator: SearchCoordinatorOutput {
    func finishSearchFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}
