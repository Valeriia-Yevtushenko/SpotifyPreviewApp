//
//  ProfileInteractorProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 31.05.2021.
//

import Foundation

protocol ProfileInteractorInputProtocol: AnyObject {
    func fetchUserProfileInfo()
    func getSelectedItem(at index: Int)
}

protocol ProfileInteractorOutputProtocol: AnyObject {
    func interactorDidFetchUserData(_ data: User)
    func interactorFailedToFetchUserData()
    func interactorDidGetSelectedItem(contentType: Int, _ data: String)
}
