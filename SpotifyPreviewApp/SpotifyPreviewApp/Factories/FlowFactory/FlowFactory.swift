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

extension FlowFactory: SearchFlowFactory {
    func makeSearchModule(serviceManager: ServiceManagerProtocol) -> (Presentable, SearchViewPresenter) {
        return SearchModuleAssembly().createModule(serviceManager)
    }
    
    func makeCategoriesModule(serviceManager: ServiceManagerProtocol) -> (Presentable, CategoriesViewPresenter) {
        return CategoriesModuleAssembly().createModule(serviceManager)
    }
}

extension FlowFactory: ProfileFlowFactory {
    func makeProfileModule(serviceManager: ServiceManagerProtocol) -> (Presentable, ProfileViewPresenter) {
        return ProfileModuleAssembly().createModule(serviceManager)
    }
}
