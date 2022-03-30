//
//  CoordinatorFactoryProtocol.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

protocol CoordinatorFactoryProtocol: AnyObject {
    func makeAuthorizationCoordinator(router: RouterProtocol,
                                      flowFactory: AuthorizationFlowFactory,
                                      authorizationService: AuthorizationServiceProtocol) ->
    AuthorizationCoordinator
    
    func makeSearchCoordinator(factory: FlowFactory,
                               router: RouterProtocol,
                               serviceManager: ServiceManagerProtocol) -> SearchCoordinator
    
    func makeTabbarCoordinator(serviceManager: ServiceManagerProtocol,
                               flowFactory: FlowFactory) -> (TabBarCoordinator, Presentable?)
    
    func makeProfileCoordinator(factory: FlowFactory,
                                router: RouterProtocol,
                                serviceManager: ServiceManagerProtocol) -> ProfileCoordinator
    
    func makePlaylistsCoordinator(type: PlaylistType,
                                  factory: FlowFactory,
                                  router: RouterProtocol,
                                  serviceManager: ServiceManagerProtocol) -> PlaylistsCoordinator
    
    func makeArtistCoordinator(artistId: String,
                               status: ArtistStatus,
                               factory: FlowFactory,
                               router: RouterProtocol,
                               serviceManager: ServiceManagerProtocol) -> ArtistCoordinator
    
    func makeAlbumCoordinator(albumId: String,
                              factory: AlbumFlow & PlayerFlow,
                              router: RouterProtocol,
                              serviceManager: ServiceManagerProtocol) -> AlbumCoordinator
    
    func makePlayerCoordinator(factory: PlayerFlow,
                               router: RouterProtocol,
                               serviceManager: ServiceManagerProtocol) -> PlayerCoordinator
}
