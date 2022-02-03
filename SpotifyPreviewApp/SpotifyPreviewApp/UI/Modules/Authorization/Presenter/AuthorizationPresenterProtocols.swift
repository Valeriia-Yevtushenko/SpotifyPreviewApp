//
//  AuthorizationPresenterProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

protocol AuthorizationViewOutputProtocol: AnyObject {
    func viewDidTapButton()
}

protocol AuthorizationViewInputProtocol: AnyObject {
    func displayErrorAlert()
}

protocol AuthorizationModuleOutput {
    func finishAuthorization()
}
