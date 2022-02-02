//
//  ProfileInteractor.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 31.05.2021.
//

import Foundation
import PromiseKit

final class ProfileViewInteractor {
    private var identifiers: (Int, [String])?
    var presenter: ProfileInteractorOutputProtocol!
    var networkService: NetworkServiceProtocol!
}

extension ProfileViewInteractor: ProfileInteractorInputProtocol {

    func fetchUserProfileInfo() {
        let promise: Promise<User> = networkService.fetch(Request.user.rawValue)
        
        promise.done {data in
            self.presenter.interactorDidFetchUserProfile(data)
        }.catch {_ in}
    }
    
    func getSelectedItem(at index: Int) {
        guard let identifier = identifiers else {
            return
        }

        presenter?.interactorDidGetSelectedItem(contentType: identifier.0, identifier.1[index])
    }
}
