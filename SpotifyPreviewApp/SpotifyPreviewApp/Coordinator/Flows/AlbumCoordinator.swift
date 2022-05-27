//
//  AlbumCoordinator.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import Foundation

protocol AlbumCoordinatorOutput: AnyObject {
    func finishAlbumFlow(coordinator: Coordinator)
}

class AlbumCoordinator: BaseCoordinator {
    private let albumId: String
    private let factory: FlowFactory
    private let router: RouterProtocol
    private let serviceManager: ServiceManagerProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    weak var playerDelegate: PlayerCoordinatorDelegate?
    weak var output: AlbumCoordinatorOutput?
    
    init(albumId: String,
         factory: FlowFactory,
         router: RouterProtocol,
         serviceManager: ServiceManagerProtocol,
         coordinatorFactory: CoordinatorFactoryProtocol) {
        self.albumId = albumId
        self.coordinatorFactory = coordinatorFactory
        self.factory = factory
        self.router = router
        self.serviceManager = serviceManager
    }
    
    override func start() {
        runAlbumModule()
    }
}

private extension AlbumCoordinator {
    func runAlbumModule() {
        let (artistModule, presenter) = factory.makeAlbumModule(with: albumId,
                                                                serviceManager: serviceManager)
        presenter.coordinator = self
        router.push(artistModule)
    }
}

extension AlbumCoordinator: AlbumModuleOutput {
    func runPlayerFlow(with tracks: [PlayerItem], for index: Int) {
        playerDelegate?.showPlayer(with: tracks, for: index)
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
    
    func finishFlow() {
        output?.finishAlbumFlow(coordinator: self)
    }
}

extension AlbumCoordinator: PlaylistsCoordinatorOutput {
    func finishPlaylistsFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}
