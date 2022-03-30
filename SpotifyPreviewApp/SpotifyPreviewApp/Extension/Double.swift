//
//  Double.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 28.03.2022.
//

import Foundation

extension Double {
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? ""
    }
}
