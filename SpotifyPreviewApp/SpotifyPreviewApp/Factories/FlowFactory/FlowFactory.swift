//
//  FlowFactory.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

class FlowFactory {}

extension FlowFactory: AuthorizationFlowFactory {
    func makeAuthorizationModule(authorizationService: AuthorizationServiceProtocol) -> (Presentable, AuthorizationPresenter) {
        return AuthorizationModuleAssembly.create(authorizationService: authorizationService)
    }
}
