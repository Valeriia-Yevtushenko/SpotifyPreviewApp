//
//  AuthorizationInteractor.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation
import PromiseKit

final class AuthorizationInteractor: AuthorizationInteractorInputProtocol {
    weak var presenter: AuthorizationInteractorOutputProtocol?
    weak var viewController: AuthorizationViewController?
    var authorizationService: AuthorizationServiceProtocol!
    
    func authorize() {
        guard let viewController = viewController else {
            return
        }
        
        firstly {
            authorizationService.authorization(viewController: viewController)
        }.done { [weak self] in
            self?.presenter?.interactorDidAuthorize()
        }.catch {_ in
            self.presenter?.interactorFailedToAuthorize()
        }
    }
}
