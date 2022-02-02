//
//  AuthorizationInteractorProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

protocol AuthorizationInteractorInputProtocol: AnyObject {
    func authorize()
}

protocol AuthorizationInteractorOutputProtocol: AnyObject {
    func interactorDidAuthorize()
    func interactorFailedToAuthorize()
}
