//
//  AlbumCoordinator.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import Foundation

protocol AlbumCoordinatorOutput: AnyObject {
    func finishArtistFlow(coordinator: Coordinator)
}

class AlbumCoordinator: BaseCoordinator {
    private let albumId: String
    private let factory: AlbumFlow & PlayerFlow
    private let router: RouterProtocol
    private let serviceManager: ServiceManagerProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    weak var playerDelegate: PlayerCoordinatorDelegate?
    weak var output: AlbumCoordinatorOutput?
    
    init(albumId: String, factory: AlbumFlow & PlayerFlow, router: RouterProtocol, serviceManager: ServiceManagerProtocol, coordinatorFactory: CoordinatorFactoryProtocol) {
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
    func runPlayerFlow(with tracks: [Track], for index: Int) {
        playerDelegate?.showPlayer(with: tracks, for: index)
    }
    
    func finishFlow() {
        output?.finishArtistFlow(coordinator: self)
    }
}
