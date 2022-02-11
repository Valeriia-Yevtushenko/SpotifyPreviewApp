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
    func viewDidSelectedSection(_ sectionType: ProfileSectionType)
}

protocol ProfileModuleOutput {
    func runPListOfArtistsModule()
    func runPlaylistsFlow()
    func runAuthorizationFlow()
}
