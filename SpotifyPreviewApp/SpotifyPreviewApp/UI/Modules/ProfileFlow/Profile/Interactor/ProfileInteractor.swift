//
//  ProfileInteractor.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 31.05.2021.
//

import Foundation
import PromiseKit

final class ProfileInteractor {
    var networkService: NetworkServiceProtocol!
    var urlBuilder: URLBuilderProtocol!
    weak var presenter: ProfileInteractorOutputProtocol?
}

extension ProfileInteractor: ProfileInteractorInputProtocol {

    func fetchUserProfileInfo() {
        let promise: Promise<User> = networkService.fetch(urlBuilder
                                                            .with(path: .user)
                                                            .build())
        
        promise.done { data in
            self.presenter?.interactorDidFetchUserData(data)
        }.catch {_ in
            self.presenter?.interactorFailedToFetchUserData()
        }
    }
}
