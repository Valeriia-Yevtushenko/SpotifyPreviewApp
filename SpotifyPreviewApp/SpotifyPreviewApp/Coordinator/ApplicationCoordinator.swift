//
//  ApplicationCoordinator.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 04.06.2021.
//

import Foundation

protocol AuthorizationDelegate: AnyObject {
    func strardAuthorizationRequest()
}

class ApplicationCoordinator: BaseCoordinator {
    private var router: RouterProtocol!
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        router.setRootModule(ViewController.instantiate(from: ViewController.identifier))
    }
}
