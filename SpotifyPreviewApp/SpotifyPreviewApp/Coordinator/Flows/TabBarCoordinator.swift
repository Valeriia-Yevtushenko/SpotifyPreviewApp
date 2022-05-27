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
    private weak var containerViewControllerDelegate: ContainerViewControllerDelegate?
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let flowFactory: FlowFactory
    private let serviceManager: ServiceManagerProtocol
    weak var output: TabbarCoordinatorOutput?
    
    init(containerViewControllerDelegate: ContainerViewControllerDelegate,
         coordinatorFactory: CoordinatorFactoryProtocol,
         serviceManager: ServiceManagerProtocol,
         flowFactory: FlowFactory) {
        self.containerViewControllerDelegate = containerViewControllerDelegate
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
        let (playerController, playerDelegate) = playerFlow()
        let searchController = searchFlow(playerDelegate: playerDelegate)
        let profileController = profileFlow(playerDelegate: playerDelegate)
        let tabbar = TabBarViewController()
        containerViewControllerDelegate?.setup(mainViewController: tabbar, miniViewController: playerController)
        tabbar.setupTabBarItems([searchController, profileController])
    }
    
    func searchFlow(playerDelegate: PlayerCoordinatorDelegate) -> UINavigationController {
        let navigationController = UINavigationController()
        let searchCoordinator = coordinatorFactory.makeSearchCoordinator(factory: flowFactory,
                                                                            router: Router(rootController: navigationController),
                                                                            serviceManager: serviceManager)
        searchCoordinator.output = self
        searchCoordinator.playerDelegate = playerDelegate
        searchCoordinator.start()
        addDependency(searchCoordinator)
        return navigationController
    }
    
    func playerFlow() -> (UINavigationController, PlayerCoordinatorDelegate) {
        let navigationController = UINavigationController()
        let playerCoordinator = coordinatorFactory.makePlayerCoordinator(factory: flowFactory,
                                                                         router: Router(rootController: navigationController),
                                                                         serviceManager: serviceManager)
        playerCoordinator.output = self
        playerCoordinator.containerViewControllerDelegate = containerViewControllerDelegate
        playerCoordinator.start()
        addDependency(playerCoordinator)
        
        return (navigationController, playerCoordinator)
    }
    
    func profileFlow(playerDelegate: PlayerCoordinatorDelegate) -> UINavigationController {
        let navigationController = UINavigationController()
        let profileCoordinator = coordinatorFactory.makeProfileCoordinator(factory: flowFactory,
                                                                              router: Router(rootController: navigationController),
                                                                           serviceManager: serviceManager)
        profileCoordinator.output = self
        profileCoordinator.playerDelegate = playerDelegate
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

extension TabBarCoordinator: PlayerCoordinatorOutput {
    func finishPlayerFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}
