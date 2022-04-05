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
    
    init(factory: FlowFactory,
         router: RouterProtocol,
         serviceManager: ServiceManagerProtocol,
         coordinatorFactory: CoordinatorFactoryProtocol) {
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
        let (searchModule, searchPresenter) = searchModule()
        searchPresenter.coordinator = self
        presenter.runSearchModule(viewController: searchModule)
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

extension SearchCoordinator: SearchModuleOutput {
    func runArtistModule(with artistId: String) {
        let artistCoordinator = coordinatorFactory.makeArtistCoordinator(artistId: artistId,
                                                                         status: .followed,
                                                                         factory: factory,
                                                                         router: router,
                                                                         serviceManager: serviceManager)
        artistCoordinator.output = self
        artistCoordinator.playerDelegate = playerDelegate
        artistCoordinator.start()
        addDependency(artistCoordinator)
    }
    
    func runAlbumModule(with albumId: String) {
        let albumCoordinator = coordinatorFactory.makeAlbumCoordinator(albumId: albumId,
                                                                       factory: factory,
                                                                       router: router,
                                                                       serviceManager: serviceManager)
        albumCoordinator.output = self
        albumCoordinator.playerDelegate = playerDelegate
        albumCoordinator.start()
        addDependency(albumCoordinator)
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
    
    func runPlayerFlow(with tracks: [PlayerItem], for index: Int) {
        playerDelegate?.showPlayer(with: tracks, for: index)
    }
}

extension SearchCoordinator: PlaylistsCoordinatorOutput {
    func finishPlaylistsFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}

extension SearchCoordinator: AlbumCoordinatorOutput {
    func finishAlbumFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}

extension SearchCoordinator: ArtistCoordinatorOutput {
    func finishArtistFlow(coordinator: Coordinator) {
        removeDependency(coordinator)
    }
}
