//
//  CoordinatorFactory.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makePlayerCoordinator(factory: PlayerFlow,
                               router: RouterProtocol,
                               serviceManager: ServiceManagerProtocol) -> PlayerCoordinator {
        return PlayerCoordinator(factory: factory,
                                 router: router,
                                 serviceManager: serviceManager,
                                 coordinatorFactory: self)
    }
    
    func makeAlbumCoordinator(albumId: String,
                              factory: AlbumFlow & PlayerFlow,
                              router: RouterProtocol,
                              serviceManager: ServiceManagerProtocol) -> AlbumCoordinator {
        return AlbumCoordinator(albumId: albumId,
                                factory: factory,
                                router: router,
                                serviceManager: serviceManager,
                                coordinatorFactory: self)
    }
    
    func makeArtistCoordinator(artistId: String,
                               status: ArtistStatus,
                               factory: FlowFactory,
                               router: RouterProtocol,
                               serviceManager: ServiceManagerProtocol) -> ArtistCoordinator {
        return ArtistCoordinator(artistId: artistId,
                                 status: status,
                                 factory: factory,
                                 router: router,
                                 serviceManager: serviceManager,
                                 coordinatorFactory: self)
    }
    
    func makePlaylistsCoordinator(type: PlaylistType,
                                  factory: FlowFactory,
                                  router: RouterProtocol,
                                  serviceManager: ServiceManagerProtocol) -> PlaylistsCoordinator {
        return PlaylistsCoordinator(type: type,
                                    factory: factory,
                                    router: router,
                                    serviceManager: serviceManager,
                                    coordinatorFactory: self)
    }
    
    func makePlaylistsCoordinator(newItemForPlaylist: String,
                                  factory: FlowFactory,
                                  router: RouterProtocol,
                                  serviceManager: ServiceManagerProtocol) -> PlaylistsCoordinator {
        return PlaylistsCoordinator(newItemForPlaylist: newItemForPlaylist,
                                    factory: factory,
                                    router: router,
                                    serviceManager: serviceManager,
                                    coordinatorFactory: self)
    }
    
    func makeProfileCoordinator(factory: FlowFactory,
                                router: RouterProtocol,
                                serviceManager: ServiceManagerProtocol) -> ProfileCoordinator {
        return ProfileCoordinator(factory: factory,
                                  router: router,
                                  serviceManager: serviceManager,
                                  coordinatorFactory: self)
    }
    
    func makeTabbarCoordinator(serviceManager: ServiceManagerProtocol,
                               flowFactory: FlowFactory) -> (TabBarCoordinator, Presentable?) {
        let containerViewControllerDelegate = ContainerViewController.instantiate(from: ContainerViewController.identifier)
        let coordinator = TabBarCoordinator(containerViewControllerDelegate: containerViewControllerDelegate,
                                            coordinatorFactory: self,
                                            serviceManager: serviceManager,
                                            flowFactory: flowFactory)
        return(coordinator, containerViewControllerDelegate)
    }
    
    func makeSearchCoordinator(factory: FlowFactory,
                               router: RouterProtocol,
                               serviceManager: ServiceManagerProtocol) -> SearchCoordinator {
        return SearchCoordinator(factory: factory,
                                 router: router, serviceManager: serviceManager,
                                 coordinatorFactory: self)
    }
    
    func makeAuthorizationCoordinator(router: RouterProtocol,
                                      flowFactory: AuthorizationFlowFactory,
                                      authorizationService: AuthorizationServiceProtocol) -> AuthorizationCoordinator {
        let coordinator = AuthorizationCoordinator(router: router,
                                                   authorizationService: authorizationService,
                                                   flowFactory: flowFactory,
                                                   coordinatorFactory: self)
        return coordinator
    }
}
