//
//  ProfileInteractor.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 31.05.2021.
//

import Foundation
import PromiseKit

final class ProfileInteractor {
    weak var presenter: ProfileInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol!
}

extension ProfileInteractor: ProfileInteractorInputProtocol {

    func fetchUserProfileInfo() {
        let promise: Promise<User> = networkService.fetch(Request.user.rawValue)
        
        promise.done {data in
            self.presenter?.interactorDidFetchUserData(data)
        }.catch {_ in
            self.presenter?.interactorFailedToFetchUserData()
        }
    }
}