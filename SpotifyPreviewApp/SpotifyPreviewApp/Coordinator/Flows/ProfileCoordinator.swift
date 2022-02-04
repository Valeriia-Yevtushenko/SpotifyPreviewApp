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
    private let router: Router
    private let serviceManager: ServiceManagerProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    weak var output: ProfileCoordinatorOutput?
    
    init(factory: FlowFactory, router: Router, serviceManager: ServiceManagerProtocol, coordinatorFactory: CoordinatorFactoryProtocol) {
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
    func runPlaylistsFlow() {
        let playlistsCoordinator = coordinatorFactory.makePlaylistsCoordinator(type: .user,
                                                                              factory: factory,
                                                                              router: router,
                                                                              serviceManager: serviceManager)
        playlistsCoordinator.output = self
        playlistsCoordinator.start()
        addDependency(playlistsCoordinator)
    }
    
    func runAuthorizationFlow() {
        output?.finishProfileFlow(coordinator: self)
    }
}

extension ProfileCoordinator: PlaylistsCoordinatorOutput {
    func finishPlaylistsFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}
