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
        return AuthorizationModuleAssembly().create(authorizationService: authorizationService)
    }
}

extension FlowFactory: SearchFlowFactory {
    func makeSearchModule(serviceManager: ServiceManagerProtocol) -> (Presentable, SearchPresenter) {
        return SearchModuleAssembly().createModule(serviceManager)
    }
    
    func makeCategoriesModule(serviceManager: ServiceManagerProtocol) -> (Presentable, CategoriesPresenter) {
        return CategoriesModuleAssembly().createModule(serviceManager)
    }
}

extension FlowFactory: ProfileFlowFactory {
    func makeListOfArtistsModule(serviceManager: ServiceManagerProtocol) -> (Presentable, ListOfArtistsPresenter) {
        return ListOfArtistsModuleAssembly().createModule(serviceManager: serviceManager)
    }
    
    func makeProfileModule(serviceManager: ServiceManagerProtocol) -> (Presentable, ProfilePresenter) {
        return ProfileModuleAssembly().createModule(serviceManager)
    }
}

extension FlowFactory: PlaylistsFlowFactory {
    func makeEditPlaylistModule(with playlist: Playlist, serviceManager: ServiceManagerProtocol) -> (Presentable, EditPlaylistPresenter) {
        return EditPlaylistModuleAssembly().createModule(with: playlist, serviceManager: serviceManager)
    }
    
    func makePlaylistModule(with playlistId: String, type: PlaylistType, serviceManager: ServiceManagerProtocol) -> (Presentable, PlaylistPresenter) {
        return PlaylistModuleAssembly().createModule(with: playlistId, type: type, serviceManager: serviceManager)
    }
    
    func makeListOfPlaylistsModule(with type: PlaylistType, serviceManager: ServiceManagerProtocol) -> (Presentable, ListOfPlaylistsPresenter) {
        return ListOfPlaylistsModuleAssembly().createModule(with: type, serviceManager: serviceManager)
    }
}
