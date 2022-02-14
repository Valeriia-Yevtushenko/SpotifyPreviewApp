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
    private let factory: ArtistFlow
    private let router: Router
    private let serviceManager: ServiceManagerProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    weak var output: ArtistCoordinatorOutput?
    
    init(artistId: String, status: ArtistStatus, factory: ArtistFlow, router: Router, serviceManager: ServiceManagerProtocol, coordinatorFactory: CoordinatorFactoryProtocol) {
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
    func finishedFlow() {
        output?.finishArtistFlow(coordinator: self)
    }
}
