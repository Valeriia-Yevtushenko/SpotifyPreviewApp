//
//  RouterProtocol.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 04.06.2021.
//

import Foundation

protocol RouterProtocol: Presentable {
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func popModule()
    func popModule(animated: Bool)
    func dismissModule()
    func dismissModule(animated: Bool)
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    func popToRootModule(animated: Bool)
}
