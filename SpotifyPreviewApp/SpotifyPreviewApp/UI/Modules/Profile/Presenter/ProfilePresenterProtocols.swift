//
//  ProfilePresenterProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 31.05.2021.
//

import Foundation

protocol ProfileViewInputProtocol: AnyObject {
    func displayErrorView()
    func configureProfileInfo(_ model: ProfileInfoModel)
}

protocol ProfileViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func logOut()
    func didSelectedItem(at index: Int)
}

protocol ProfileModuleOutput {
    func runAuthorizationFlow()
}
