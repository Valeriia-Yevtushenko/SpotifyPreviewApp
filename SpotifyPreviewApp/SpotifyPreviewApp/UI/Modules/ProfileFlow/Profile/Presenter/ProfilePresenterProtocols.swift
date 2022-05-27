//
//  ProfilePresenterProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 31.05.2021.
//

import Foundation

protocol ProfileViewInputProtocol: AnyObject {
    func handleError()
    func configureProfileInfo(_ model: ProfileInfoModel)
}

protocol ProfileViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidTapReload()
    func viewDidTapLogOut()
    func viewDidTapOnPlaylistsSection()
    func viewDidTapOnFollowsSection()
    func viewDidTapOnSavedTracksSection()
}

protocol ProfileModuleOutput {
    func runListOfArtistsModule()
    func runListOfSavedTracksModule()
    func runPlaylistsFlow()
    func runAuthorizationFlow()
}
