//
//  ListOfPlaylists.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 04.02.2022.
//

import Foundation

protocol PlaylistsCoordinatorOutput: AnyObject {
    func finishPlaylistsFlow(coordinator: Coordinator)
}

class PlaylistsCoordinator: BaseCoordinator {
    private let factory: FlowFactory
    private let router: RouterProtocol
    private let serviceManager: ServiceManagerProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let type: PlaylistType
    private var newItemForPlaylist: String?
    weak var playerDelegate: PlayerCoordinatorDelegate?
    weak var output: PlaylistsCoordinatorOutput?
    
    init(type: PlaylistType,
         factory: FlowFactory,
         router: RouterProtocol,
         serviceManager: ServiceManagerProtocol,
         coordinatorFactory: CoordinatorFactoryProtocol) {
        self.coordinatorFactory = coordinatorFactory
        self.factory = factory
        self.router = router
        self.serviceManager = serviceManager
        self.type = type
    }
    
    init(newItemForPlaylist: String,
         factory: FlowFactory,
         router: RouterProtocol,
         serviceManager: ServiceManagerProtocol,
         coordinatorFactory: CoordinatorFactoryProtocol) {
        self.coordinatorFactory = coordinatorFactory
        self.factory = factory
        self.router = router
        self.serviceManager = serviceManager
        self.type = .user
        self.newItemForPlaylist = newItemForPlaylist
    }
    
    override func start() {
        if let newItemForPlaylist = newItemForPlaylist {
            showListOfPlaylists(for: newItemForPlaylist)
        } else {
            runListOfPlaylistsModule()
        }
    }
}

private extension PlaylistsCoordinator {
    func runListOfPlaylistsModule() {
        let (playlistModule, presenter) = factory.makeListOfPlaylistsModule(with: type, serviceManager: serviceManager)
        presenter.coordinator = self
        router.push(playlistModule)
    }
}

extension PlaylistsCoordinator: ListOfPlaylistsModuleOutput {
    func dismiss() {
        router.dismissModule()
        
        if newItemForPlaylist != nil {
            output?.finishPlaylistsFlow(coordinator: self)
        }
    }
    
    func runPlaylistModule(with playlistId: String, type: PlaylistType) {
        let (playlistModule, presenter) = factory.makePlaylistModule(with: playlistId, type: type, serviceManager: serviceManager)
        presenter.coordinator = self
        router.push(playlistModule)
    }
}

extension PlaylistsCoordinator: PlaylistModuleOutput {
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
    
    func showListOfPlaylists(for newItemForPlaylist: String) {
        let (playlistModule, presenter) = factory.makeListOfPlaylistsModule(with: newItemForPlaylist,
                                                                            serviceManager: serviceManager)
        presenter.coordinator = self
        router.present(playlistModule)
    }
    
    func runPlayerFlow(with tracks: [PlayerItem], for index: Int) {
        playerDelegate?.showPlayer(with: tracks, for: index)
    }
    
    func runEditPlaylistModule(with playlist: Playlist) {
        let (playlistModule, presenter) = factory.makeEditPlaylistModule(with: playlist, serviceManager: serviceManager)
        presenter.coordinator = self
        playlistModule.toPresent()?.modalPresentationStyle = .fullScreen
        router.present(playlistModule)
    }
    
    func backToPlaylists() {
        router.popModule()
    }
}

extension PlaylistsCoordinator: EditPlaylistModuleOutput {
    func backToPlaylist() {
        router.dismissModule()
    }
}

extension PlaylistsCoordinator: ArtistCoordinatorOutput {
    func finishArtistFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}

extension PlaylistsCoordinator: AlbumCoordinatorOutput {
    func finishAlbumFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}
