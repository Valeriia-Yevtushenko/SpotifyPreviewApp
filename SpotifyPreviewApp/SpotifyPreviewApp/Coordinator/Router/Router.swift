//
//  Router.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 04.06.2021.
//

import UIKit.UIViewController

class Router {
    private weak var rootController: UINavigationController?
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
}

extension Router: RouterProtocol {
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?) {
        push(module, animated: true)
    }
    
    func push(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent(),
              (controller is UINavigationController == false) else {
            return
        }
        
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func popModule() {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool) {
        rootController?.popViewController(animated: animated)
    }
    
    func dismissModule() {
        dismissModule(animated: true)
    }
    
    func dismissModule(animated: Bool) {
        rootController?.dismiss(animated: animated, completion: nil)
    }
    
    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootModule(animated: Bool) {
         rootController?.popToRootViewController(animated: animated)
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
}
