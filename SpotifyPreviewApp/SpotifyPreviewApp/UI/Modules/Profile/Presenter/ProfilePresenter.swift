//
//  ProfilePresenter.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 31.05.2021.
//

import Foundation

final class ProfileViewPresenter {
    weak var view: ProfileViewInputProtocol?
    var coordinator: ProfileModuleOutput?
    var interactor: ProfileInteractorInputProtocol?
}

extension ProfileViewPresenter: ProfileViewOutputProtocol {
    func viewDidTapReload() {
        interactor?.fetchUserProfileInfo()
    }
    
    func viewDidTapLogOut() {
        coordinator?.runAuthorizationFlow()
    }
    
    func viewDidSelectedItem(at index: Int) {
        interactor?.getSelectedItem(at: index)
    }
    
    func viewDidLoad() {
        interactor?.fetchUserProfileInfo()
    }
}

extension ProfileViewPresenter: ProfileInteractorOutputProtocol {
    func interactorDidGetSelectedItem(contentType: Int, _ data: String) {
        
    }
    
    func interactorDidFetchUserData(_ data: User) {
        view?.configureProfileInfo(ProfileInfoModel(userImage: data.images?.first?.url, username: data.displayName, userEmail: data.email))

    }
    
    func interactorFailedToFetchUserData() {
        view?.handleError()
    }
}
