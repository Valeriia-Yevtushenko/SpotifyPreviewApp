//
//  ArtistCoordinator.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 14.02.2022.
//

import Foundation

protocol ArtistCoordinatorOutput: AnyObject {
    func finishArtistFlow(coordinator: Coordinator)
}

class ArtistCoordinator: BaseCoordinator {
    private let artistId: String
    private let status: ArtistStatus
    private let factory: ArtistFlow&AlbumFlow
    private let router: Router
    private let serviceManager: ServiceManagerProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    weak var output: ArtistCoordinatorOutput?
    
    init(artistId: String, status: ArtistStatus, factory: ArtistFlow&AlbumFlow, router: Router, serviceManager: ServiceManagerProtocol, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.artistId = artistId
        self.coordinatorFactory = coordinatorFactory
        self.factory = factory
        self.router = router
        self.serviceManager = serviceManager
        self.status = status
    }
    
    override func start() {
        runArtistModule()
    }
}

private extension ArtistCoordinator {
    func runArtistModule() {
        let (artistModule, presenter) = factory.makeArtistModule(with: artistId, status: status, serviceManager: serviceManager)
        presenter.coordinator = self
        router.push(artistModule)
    }
}

extension ArtistCoordinator: ArtistModuleOutput {
    func runAlbumFlow(with identifier: String) {
        let albumCoordinator = coordinatorFactory.makeAlbumCoordinator(albumId: identifier,
                                                                         factory: factory,
                                                                         router: router,
                                                                         serviceManager: serviceManager)
        albumCoordinator.output = self
        albumCoordinator.start()
        addDependency(albumCoordinator)
    }
    
    func finishedFlow() {
        output?.finishArtistFlow(coordinator: self)
    }
}

extension ArtistCoordinator: AlbumCoordinatorOutput {
    func finishArtistFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}
