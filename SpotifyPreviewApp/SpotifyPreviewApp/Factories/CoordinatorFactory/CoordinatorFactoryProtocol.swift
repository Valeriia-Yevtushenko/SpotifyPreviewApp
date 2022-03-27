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
                               router: Router,
                               serviceManager: ServiceManagerProtocol) -> SearchCoordinator
    
    func makeTabbarCoordinator(serviceManager: ServiceManagerProtocol,
                               flowFactory: FlowFactory) -> (TabBarCoordinator, Presentable?)
    
    func makeProfileCoordinator(factory: FlowFactory,
                                router: Router,
                                serviceManager: ServiceManagerProtocol) -> ProfileCoordinator
    
    func makePlaylistsCoordinator(type: PlaylistType,
                                  factory: FlowFactory,
                                  router: Router,
                                  serviceManager: ServiceManagerProtocol) -> PlaylistsCoordinator
    
    func makeArtistCoordinator(artistId: String,
                               status: ArtistStatus,
                               factory: FlowFactory,
                               router: Router,
                               serviceManager: ServiceManagerProtocol) -> ArtistCoordinator
    
    func makeAlbumCoordinator(albumId: String,
                              factory: AlbumFlow & PlayerFlow,
                              router: Router,
                              serviceManager: ServiceManagerProtocol) -> AlbumCoordinator
    
    func makePlayerCoordinator(with tracks: [Track],
                               for index: Int,
                               factory: PlayerFlow,
                               router: Router,
                               serviceManager: ServiceManagerProtocol) -> PlayerCoordinator
}
