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

protocol PlaylistsFlowFactory {
    func makeListOfPlaylistsModule(with type: PlaylistType, serviceManager: ServiceManagerProtocol) -> (Presentable, ListOfPlaylistsViewPresenter)
    
    func makePlaylistModule(with playlistId: String, type: PlaylistType, serviceManager: ServiceManagerProtocol) -> (Presentable, PlaylistViewPresenter)
    
    func makeEditPlaylistModule(with playlist: Playlist, serviceManager: ServiceManagerProtocol) -> (Presentable, EditPlaylistViewPresenter)
}
