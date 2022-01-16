//
//  Presentable.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import UIKit.UIViewController

protocol Presentable: AnyObject {
    func toPresent() -> UIViewController?
}
