//
//  BaseCoordinator.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 04.06.2021.
//

import Foundation

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {}
}

extension BaseCoordinator {
    func addDependency(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator else {
            return
        }
        
        for element in childCoordinators where element === coordinator {
            return
        }
        
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false,
              let coordinator = coordinator else { return }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
