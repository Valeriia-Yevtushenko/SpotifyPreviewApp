//
//  FlowFactoryProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

protocol AuthorizationFlowFactory {
    func makeAuthorizationModule(authorizationService: AuthorizationServiceProtocol) -> (Presentable, AuthorizationPresenter)
}
