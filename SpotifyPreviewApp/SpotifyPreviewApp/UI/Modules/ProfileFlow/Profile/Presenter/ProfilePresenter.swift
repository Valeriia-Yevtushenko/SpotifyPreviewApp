//
//  ProfilePresenter.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 31.05.2021.
//

import Foundation

final class ProfilePresenter {
    weak var view: ProfileViewInputProtocol?
    var coordinator: ProfileModuleOutput?
    var interactor: ProfileInteractorInputProtocol?
}

extension ProfilePresenter: ProfileViewOutputProtocol {
    func viewDidTapOnPlaylistsSection() {
        coordinator?.runPlaylistsFlow()
    }
    
    func viewDidTapOnFollowsSection() {
        coordinator?.runListOfArtistsModule()
    }
    
    func viewDidTapOnSavedTracksSection() {
        coordinator?.runListOfSavedTracksModule()
    }
    
    func viewDidTapReload() {
        interactor?.fetchUserProfileInfo()
    }
    
    func viewDidTapLogOut() {
        coordinator?.runAuthorizationFlow()
    }
    
    func viewDidLoad() {
        interactor?.fetchUserProfileInfo()
    }
}

extension ProfilePresenter: ProfileInteractorOutputProtocol {
    func interactorDidFetchUserData(_ data: User) {
        view?.configureProfileInfo(ProfileInfoModel(userImage: data.images?.first?.url, username: data.displayName, userEmail: data.email))

    }
    
    func interactorFailedToFetchUserData() {
        view?.handleError()
    }
}
