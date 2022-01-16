//
//  ApplicationCoordinator.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 04.06.2021.
//

import Foundation
import OAuthSwift

protocol AuthorizationDelegate: AnyObject {
    func strardAuthorizationRequest()
}

class ApplicationCoordinator: BaseCoordinator {
    private let serviceManager: ServiceManagerProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let router: RouterProtocol
    private let flowFactory: FlowFactory
    
    init(router: RouterProtocol, serviceManager: ServiceManagerProtocol, flowFactory: FlowFactory, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.flowFactory = flowFactory
        self.serviceManager = serviceManager
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runAuthorizationFlow()
    }
}

private extension ApplicationCoordinator {
    func runAuthorizationFlow() {
        let coordinator = coordinatorFactory.makeAuthorizationCoordinator(router: router,
                                                                          flowFactory: flowFactory,
                                                                          authorizationService: serviceManager.authorization)
        coordinator.output = self
        addDependency(coordinator)
        coordinator.start()
    }
}

extension ApplicationCoordinator: AuthorizationCoordinatorOutput {
    func finishAuthorizationFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}
