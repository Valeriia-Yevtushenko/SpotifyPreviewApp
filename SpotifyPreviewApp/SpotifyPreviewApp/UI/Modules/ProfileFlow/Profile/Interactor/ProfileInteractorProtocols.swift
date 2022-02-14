//
//  ProfileInteractorProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 31.05.2021.
//

import Foundation

protocol ProfileInteractorInputProtocol: AnyObject {
    func fetchUserProfileInfo()
}

protocol ProfileInteractorOutputProtocol: AnyObject {
    func interactorDidFetchUserData(_ data: User)
    func interactorFailedToFetchUserData()
}
