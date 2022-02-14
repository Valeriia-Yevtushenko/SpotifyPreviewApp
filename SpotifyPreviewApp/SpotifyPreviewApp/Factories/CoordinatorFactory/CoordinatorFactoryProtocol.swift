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
    
    func makeSearchCoordinator(factory: FlowFactory, router: Router, serviceManager: ServiceManagerProtocol) -> SearchCoordinator
    
    func makeTabbarCoordinator(serviceManager: ServiceManagerProtocol, flowFactory: FlowFactory) -> (configurator: TabBarCoordinator, toPresent: Presentable?)
    
    func makeProfileCoordinator(factory: FlowFactory, router: Router, serviceManager: ServiceManagerProtocol) -> ProfileCoordinator
    
    func makePlaylistsCoordinator(type: PlaylistType, factory: FlowFactory, router: Router, serviceManager: ServiceManagerProtocol) -> PlaylistsCoordinator
    
    func makeArtistCoordinator(artistId: String, status: ArtistStatus, factory: ArtistFlow, router: Router, serviceManager: ServiceManagerProtocol) -> ArtistCoordinator
}
