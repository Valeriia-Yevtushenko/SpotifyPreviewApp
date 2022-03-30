//
//  SearchCoordinator.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 01.02.2022.
//

import Foundation

protocol SearchCoordinatorOutput: AnyObject {
    func finishSearchFlow(coordinator: Coordinator)
}

class SearchCoordinator: BaseCoordinator {
    private let factory: FlowFactory
    private let router: RouterProtocol
    private let serviceManager: ServiceManagerProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    weak var playerDelegate: PlayerCoordinatorDelegate?
    weak var output: SearchCoordinatorOutput?
    
    init(factory: FlowFactory, router: RouterProtocol, serviceManager: ServiceManagerProtocol, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.factory = factory
        self.router = router
        self.serviceManager = serviceManager
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runCategoriesModule()
    }
}

private extension SearchCoordinator {
    func runCategoriesModule() {
        let (categoriesModule, presenter) = factory.makeCategoriesModule(serviceManager: serviceManager)
        presenter.runSearchModule(viewController: searchModule().0)
        presenter.coordinator = self
        router.setRootModule(categoriesModule, hideBar: false)
        
    }

    func searchModule() -> (Presentable, SearchPresenter) {
        return factory.makeSearchModule(serviceManager: serviceManager)
    }
}

extension SearchCoordinator: CategoriesModuleOutput {
    func runPlaylistsFlow(_ data: String) {
        let playlistCoordinator = coordinatorFactory.makePlaylistsCoordinator(type: .category(data),
                                                                              factory: factory,
                                                                              router: router,
                                                                              serviceManager: serviceManager)
        playlistCoordinator.output = self
        playlistCoordinator.playerDelegate = playerDelegate
        playlistCoordinator.start()
        addDependency(playlistCoordinator)
    }
}

extension SearchCoordinator: PlaylistsCoordinatorOutput {
    func finishPlaylistsFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}
