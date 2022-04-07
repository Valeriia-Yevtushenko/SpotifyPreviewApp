//
//  CALayer.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 07.04.2022.
//

import UIKit

extension CALayer {
    var borderUIColor: UIColor {
        get {
            return UIColor(cgColor: self.borderColor!)
        }
        
        set {
            self.borderColor = newValue.cgColor
        }
    }
}
