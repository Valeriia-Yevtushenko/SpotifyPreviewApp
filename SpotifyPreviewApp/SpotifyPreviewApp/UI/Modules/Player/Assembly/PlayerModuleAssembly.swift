//
//  PlayerModuleAssembly.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 06.03.2022.
//

import UIKit

final class PlayerModuleAssembly {
    func createModule(with albumId: String, serviceManager: ServiceManagerProtocol) -> UIViewController {
        let playerViewController = PlayerViewController.instantiate(from: PlayerViewController.identifier)
        return playerViewController
    }
}
