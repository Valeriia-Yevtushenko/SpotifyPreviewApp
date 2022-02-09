//
//  EditPlaylistPresenterProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 06.02.2022.
//

import Foundation

protocol EditPlaylistViewInputProtocol: AnyObject {
    
}

protocol EditPlaylistViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidTapSavePlaylistInfo()
}

protocol EditPlaylistModuleOutput {
    func backToPlaylist()
    func finishedFlow()
}
