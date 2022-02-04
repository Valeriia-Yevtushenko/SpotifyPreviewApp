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
    func runPlaylistModule(data: String) {
        
    }
}
