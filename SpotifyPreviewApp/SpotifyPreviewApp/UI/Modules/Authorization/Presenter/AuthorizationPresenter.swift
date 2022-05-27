//
//  AuthorizationPresenter.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

final class AuthorizationPresenter {
    weak var view: AuthorizationViewInputProtocol?
    var coordinator: AuthorizationModuleOutput?
    var interactor: AuthorizationInteractorInputProtocol?
}

extension AuthorizationPresenter: AuthorizationViewOutputProtocol {
    func viewDidTapButton() {
        interactor?.authorize()
    }
}

extension AuthorizationPresenter: AuthorizationInteractorOutputProtocol {
    func interactorFailedToAuthorize() {
        view?.displayErrorAlert()
    }
    
    func interactorDidAuthorize() {
        coordinator?.finishAuthorization()
    }
}
