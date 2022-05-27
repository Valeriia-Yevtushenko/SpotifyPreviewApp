//
//  PlayerCoordinator.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 19.03.2022.
//

import Foundation

protocol PlayerCoordinatorDelegate: AnyObject {
    func showPlayer(with tracks: [PlayerItem], for index: Int)
    func showMiniPlayer()
}

protocol PlayerCoordinatorOutput: AnyObject {
    func finishPlayerFlow(coordinator: Coordinator)
}

class PlayerCoordinator: BaseCoordinator {
    private let factory: PlayerFlow
    private let router: RouterProtocol
    private let serviceManager: ServiceManagerProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private weak var miniPlayerDelegate: MiniPlayerModuleInput?
    weak var containerViewControllerDelegate: ContainerViewControllerDelegate?
    weak var output: PlayerCoordinatorOutput?
    
    init(factory: PlayerFlow,
         router: RouterProtocol,
         serviceManager: ServiceManagerProtocol,
         coordinatorFactory: CoordinatorFactoryProtocol) {
        self.coordinatorFactory = coordinatorFactory
        self.factory = factory
        self.router = router
        self.serviceManager = serviceManager
    }
    
    override func start() {
        runMiniPlayerModule()
    }
}

private extension PlayerCoordinator {
    func runMiniPlayerModule() {
        let (playerModule, presenter) = factory.makeMiniPlayerModule(serviceManager: serviceManager)
        presenter.coordinator = self
        miniPlayerDelegate = presenter
        router.setRootModule(playerModule, hideBar: true)
    }
}

extension PlayerCoordinator: PlayerModuleOutput {
    func dismissPlayer(with success: Bool) {
        if success {
            showMiniPlayer()
        } else {
            containerViewControllerDelegate?.isMiniContainerViewHidden = true
        }
        
        router.dismissModule()
    }
}

extension PlayerCoordinator: MiniPlayerModuleOutput {
    func hideMiniPlayer() {
        containerViewControllerDelegate?.isMiniContainerViewHidden = false
    }
    
    func openPlayer() {
        let (playerModule, presenter) = factory.makePlayerModule(serviceManager: serviceManager)
        presenter.coordinator = self
        router.present(playerModule)
    }
}

extension PlayerCoordinator: PlayerCoordinatorDelegate {
    func showPlayer(with tracks: [PlayerItem], for index: Int) {
        let (playerModule, presenter) = factory.makePlayerModule(with: tracks,
                                                                 for: index,
                                                                 serviceManager: serviceManager)
        
        presenter.coordinator = self
        router.present(playerModule)
    }
    
    func showMiniPlayer() {
        containerViewControllerDelegate?.isMiniContainerViewHidden = false
        miniPlayerDelegate?.refreshMiniPlayer()
    }
}
