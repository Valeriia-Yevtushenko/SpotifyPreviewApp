//
//  CoordinatorFactoryProtocol.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

protocol CoordinatorFactoryProtocol: AnyObject {
    func makeAuthorizationCoordinator(router: RouterProtocol, flowFactory: AuthorizationFlowFactory, authorizationService: AuthorizationServiceProtocol) ->
    AuthorizationCoordinator
}
