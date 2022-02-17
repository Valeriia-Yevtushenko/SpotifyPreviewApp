//
//  FlowFactoryProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

protocol AuthorizationFlowFactory: AnyObject {
    func makeAuthorizationModule(authorizationService: AuthorizationServiceProtocol) -> (Presentable, AuthorizationPresenter)
}

protocol SearchFlowFactory: AnyObject {
    func makeSearchModule(serviceManager: ServiceManagerProtocol) -> (Presentable, SearchPresenter)
    func makeCategoriesModule(serviceManager: ServiceManagerProtocol) -> (Presentable, CategoriesPresenter)
}

protocol ProfileFlowFactory: AnyObject {
    func makeProfileModule(serviceManager: ServiceManagerProtocol) -> (Presentable, ProfilePresenter)
    func makeListOfArtistsModule(serviceManager: ServiceManagerProtocol) -> (Presentable, ListOfArtistsPresenter)
}

protocol PlaylistsFlowFactory: AnyObject {
    func makeListOfPlaylistsModule(with type: PlaylistType, serviceManager: ServiceManagerProtocol) -> (Presentable, ListOfPlaylistsPresenter)
    
    func makePlaylistModule(with playlistId: String, type: PlaylistType, serviceManager: ServiceManagerProtocol) -> (Presentable, PlaylistPresenter)
    
    func makeEditPlaylistModule(with playlist: Playlist, serviceManager: ServiceManagerProtocol) -> (Presentable, EditPlaylistPresenter)
}

protocol ArtistFlow: AnyObject {
    func makeArtistModule(with artistId: String, status: ArtistStatus, serviceManager: ServiceManagerProtocol) -> (Presentable, ArtistPresenter)
}

protocol AlbumFlow: AnyObject {
    func makeAlbumModule(with albumId: String, serviceManager: ServiceManagerProtocol) -> (Presentable, AlbumPresenter)
}
