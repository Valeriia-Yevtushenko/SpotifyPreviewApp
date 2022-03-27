//
//  PlayerCoordinator.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 19.03.2022.
//

import Foundation

protocol PlayerCoordinatorOutput: AnyObject {
    func finishPlayerFlow(coordinator: Coordinator)
}

class PlayerCoordinator: BaseCoordinator {
    private let tracks: [Track]
    private let index: Int
    private let factory: PlayerFlow
    private let router: Router
    private let serviceManager: ServiceManagerProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    weak var output: PlayerCoordinatorOutput?
    
    init(tracks: [Track], index: Int, factory: PlayerFlow, router: Router, serviceManager: ServiceManagerProtocol, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.index = index
        self.tracks = tracks
        self.coordinatorFactory = coordinatorFactory
        self.factory = factory
        self.router = router
        self.serviceManager = serviceManager
    }
    
    override func start() {
        runPlayerModule()
    }
}

private extension PlayerCoordinator {
    func runPlayerModule() {
        let (artistModule, presenter) = factory.makePlayerModule(with: tracks,
                                                                 for: index,
                                                                 serviceManager: serviceManager)
        presenter.coordinator = self
        router.present(artistModule)
    }
}

extension PlayerCoordinator: PlayerModuleOutput {
    func finishFlow() {
        output?.finishPlayerFlow(coordinator: self)
    }
}
