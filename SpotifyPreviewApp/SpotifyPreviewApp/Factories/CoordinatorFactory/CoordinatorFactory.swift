//
//  CoordinatorFactory.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeTabbarCoordinator(serviceManager: ServiceManagerProtocol, flowFactory: FlowFactory) -> (configurator: TabBarCoordinator, toPresent: Presentable?) {
        let tabBarViewController = TabBarViewController()
        let coordinator = TabBarCoordinator(tabBarViewControllerDelegat: tabBarViewController,
                                            coordinatorFactory: self, serviceManager: serviceManager, flowFactory: flowFactory)
        return(coordinator, tabBarViewController)
    }
    
    func makeSearchCoordinator(factory: FlowFactory, router: Router, serviceManager: ServiceManagerProtocol) -> SearchCoordinator {
        return SearchCoordinator(factory: factory, router: router, serviceManager: serviceManager, coordinatorFactory: self)
    }
    
    func makeAuthorizationCoordinator(router: RouterProtocol, flowFactory: AuthorizationFlowFactory, authorizationService: AuthorizationServiceProtocol) -> AuthorizationCoordinator {
        let coordinator = AuthorizationCoordinator(router: router,
                                                   authorizationService: authorizationService,
                                                   flowFactory: flowFactory,
                                                   coordinatorFactory: self)
        return coordinator
    }
}
