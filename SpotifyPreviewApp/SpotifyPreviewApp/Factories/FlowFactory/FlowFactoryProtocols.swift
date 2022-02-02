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

protocol SearchFlowFactory {
    func makeSearchModule(serviceManager: ServiceManagerProtocol) -> (Presentable, SearchViewPresenter)
    func makeCategoriesModule(serviceManager: ServiceManagerProtocol) -> (Presentable, CategoriesViewPresenter)
}

protocol ProfileFlowFactory {
    func makeProfileModule(serviceManager: ServiceManagerProtocol) -> (Presentable, ProfileViewPresenter)
}
