//
//  SavedTracksModuleAssembly.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 05.04.2022.
//

import UIKit

class SavedTracksModuleAssembly {
    func createModule(_ serviceManager: ServiceManagerProtocol) -> (UIViewController, SavedTracksPresenter) {
        let savedTracksViewController = SavedTracksViewController.instantiate(from: SavedTracksViewController.identifier)
        let dataSource = SavedTracksTableViewDataSource()
        let presenter = SavedTracksPresenter()
        savedTracksViewController.dataSource = dataSource
        let interactor = SavedTracksInteractor()
        interactor.presenter = presenter
        interactor.databaseManager = serviceManager.database()
        presenter.interactor = interactor
        presenter.view = savedTracksViewController
        savedTracksViewController.output = presenter
        return (savedTracksViewController, presenter)
    }
}
