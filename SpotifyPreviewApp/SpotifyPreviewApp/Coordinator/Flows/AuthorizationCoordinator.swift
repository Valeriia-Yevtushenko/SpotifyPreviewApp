//
//  AuthorizationCoordinator.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 04.06.2021.
//

import Foundation

protocol AuthorizationCoordinatorOutput: AnyObject {
    func finishAuthorizationFlow(coordinator: Coordinator)
}

class AuthorizationCoordinator: BaseCoordinator {
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let flowFactory: AuthorizationFlowFactory
    private let authorizationService: AuthorizationServiceProtocol
    weak var output: AuthorizationCoordinatorOutput?
    
    init(router: RouterProtocol,
         authorizationService: AuthorizationServiceProtocol,
         flowFactory: AuthorizationFlowFactory,
         coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.flowFactory = flowFactory
        self.authorizationService = authorizationService
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runAuthorizationModule()
    }
}

private extension AuthorizationCoordinator {
    func runAuthorizationModule() {
        let (viewController, presenter) = flowFactory.makeAuthorizationModule(authorizationService: authorizationService)
        presenter.coordinator = self
        router.setRootModule(viewController, hideBar: true)
    }
}

extension AuthorizationCoordinator: AuthorizationModuleOutput {
    func finishAuthorization() {
        output?.finishAuthorizationFlow(coordinator: self)
    }
}
