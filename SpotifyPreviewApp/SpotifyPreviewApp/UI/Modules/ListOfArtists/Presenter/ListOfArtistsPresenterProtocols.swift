//
//  ListOfArtistsPresenterProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import Foundation

protocol ListOfArtistsViewInputProtocol: AnyObject {
    func setupData(_ model: [TableViewCellModel])
    func reloadData()
    func displayLabel(with text: String)
}

protocol ListOfArtistsViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidRefresh()
    func viewSelectedItem(at index: Int)
}

protocol ListOfArtistsModuleOutput {
    func runArtistFlow(with identifier: String)
}
