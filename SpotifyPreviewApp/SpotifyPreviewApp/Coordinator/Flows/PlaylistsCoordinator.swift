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
    private let router: Router
    private let serviceManager: ServiceManagerProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let type: PlaylistType
    weak var output: PlaylistsCoordinatorOutput?
    
    init(factory: FlowFactory, router: Router, serviceManager: ServiceManagerProtocol, coordinatorFactory: CoordinatorFactoryProtocol, type: PlaylistType) {
        self.coordinatorFactory = coordinatorFactory
        self.factory = factory
        self.router = router
        self.serviceManager = serviceManager
        self.type = type
    }
    
    override func start() {
        runListOfPlaylistsModule()
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
    func runPlaylistModule(with playlistId: String, type: PlaylistType) {
        let (playlistModule, presenter) = factory.makePlaylistModule(with: playlistId, type: type, serviceManager: serviceManager)
        presenter.coordinator = self
        router.push(playlistModule)
    }
}

extension PlaylistsCoordinator: PlaylistModuleOutput {
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
