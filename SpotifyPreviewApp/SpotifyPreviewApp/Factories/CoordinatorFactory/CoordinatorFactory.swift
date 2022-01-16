//
//  CoordinatorFactory.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeAuthorizationCoordinator(router: RouterProtocol, flowFactory: AuthorizationFlowFactory, authorizationService: AuthorizationServiceProtocol) -> AuthorizationCoordinator {
        let coordinator = AuthorizationCoordinator(router: router,
                                                   authorizationService: authorizationService,
                                                   flowFactory: flowFactory,
                                                   coordinatorFactory: self)
        return coordinator
    }
}
