//
//  ProfileCoordinator.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 02.02.2022.
//

import Foundation

protocol ProfileCoordinatorOutput: AnyObject {
    func finishProfileFlow(coordinator: Coordinator)
}

class ProfileCoordinator: BaseCoordinator {
    private let factory: FlowFactory
    private let router: RouterProtocol
    private let serviceManager: ServiceManagerProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    weak var playerDelegate: PlayerCoordinatorDelegate?
    weak var output: ProfileCoordinatorOutput?
    
    init(factory: FlowFactory,
         router: RouterProtocol,
         serviceManager: ServiceManagerProtocol,
         coordinatorFactory: CoordinatorFactoryProtocol) {
        self.coordinatorFactory = coordinatorFactory
        self.factory = factory
        self.router = router
        self.serviceManager = serviceManager
    }
    
    override func start() {
        runProfileModule()
    }
}

private extension ProfileCoordinator {
    func runProfileModule() {
        let (profileModule, presenter) = factory.makeProfileModule(serviceManager: serviceManager)
        presenter.coordinator = self
        router.setRootModule(profileModule, hideBar: false)
    }
}

extension ProfileCoordinator: ProfileModuleOutput {
    func runListOfSavedTracksModule() {
        let (listOfSavedTracksModule, presenter) = factory.makeListOfSavedTracksModule(serviceManager: serviceManager)
        presenter.coordinator = self
        router.push(listOfSavedTracksModule)
    }
    
    func runListOfArtistsModule() {
        let (listOfArtistsModule, presenter) = factory.makeListOfArtistsModule(serviceManager: serviceManager)
        presenter.coordinator = self
        router.push(listOfArtistsModule)
    }
    
    func runPlaylistsFlow() {
        let playlistsCoordinator = coordinatorFactory.makePlaylistsCoordinator(type: .user,
                                                                              factory: factory,
                                                                              router: router,
                                                                              serviceManager: serviceManager)
        playlistsCoordinator.output = self
        playlistsCoordinator.playerDelegate = playerDelegate
        playlistsCoordinator.start()
        addDependency(playlistsCoordinator)
    }
    
    func runAuthorizationFlow() {
        output?.finishProfileFlow(coordinator: self)
    }
}

extension ProfileCoordinator: ListOfArtistsModuleOutput {
    func runArtistFlow(with identifier: String) {
        let artistCoordinator = coordinatorFactory.makeArtistCoordinator(artistId: identifier,
                                                                         status: .followed,
                                                                         factory: factory,
                                                                         router: router,
                                                                         serviceManager: serviceManager)
        artistCoordinator.output = self
        artistCoordinator.playerDelegate = playerDelegate
        artistCoordinator.start()
        addDependency(artistCoordinator)
    }
}

extension ProfileCoordinator: SavedTracksModuleOutput {
    func runArtistModule(with artistId: String) {
        let artistCoordinator = coordinatorFactory.makeArtistCoordinator(artistId: artistId,
                                                                         status: .followed,
                                                                         factory: factory,
                                                                         router: router,
                                                                         serviceManager: serviceManager)
        artistCoordinator.output = self
        artistCoordinator.playerDelegate = playerDelegate
        artistCoordinator.start()
        addDependency(artistCoordinator)
    }
    
    func runAlbumModule(with albumId: String) {
        let albumCoordinator = coordinatorFactory.makeAlbumCoordinator(albumId: albumId,
                                                                       factory: factory,
                                                                       router: router,
                                                                       serviceManager: serviceManager)
        albumCoordinator.output = self
        albumCoordinator.playerDelegate = playerDelegate
        albumCoordinator.start()
        addDependency(albumCoordinator)
    }
    
    func runListOfPlaylistFlow(for newItemForPlaylist: String) {
        let playlistsCoordinator = coordinatorFactory.makePlaylistsCoordinator(newItemForPlaylist: newItemForPlaylist,
                                                                              factory: factory,
                                                                              router: router,
                                                                              serviceManager: serviceManager)
        playlistsCoordinator.output = self
        playlistsCoordinator.playerDelegate = playerDelegate
        playlistsCoordinator.start()
        addDependency(playlistsCoordinator)
    }
    
    func runPlayerFlow(with tracks: [Track], for index: Int) {
        playerDelegate?.showPlayer(with: tracks, for: index)
    }
}

extension ProfileCoordinator: ArtistCoordinatorOutput {
    func finishArtistFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}

extension ProfileCoordinator: PlaylistsCoordinatorOutput {
    func finishPlaylistsFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}

extension ProfileCoordinator: AlbumCoordinatorOutput {
    func finishAlbumFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}
