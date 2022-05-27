//
//  ToastView.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 06.02.2022.
//

import UIKit

class ToastView: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let superview = superview else { return }
        let length = min(superview.bounds.width / 2, 375)
        bounds = CGRect(x: 0, y: 0, width: length, height: length)
        layer.position = CGPoint(x: superview.bounds.width / 2, y: superview.bounds.height / 2)
    }
}

extension ToastView {
    func setupView() {
        clipsToBounds = false
        layer.cornerRadius = .pi
        textAlignment = .center
        textColor = .label
        numberOfLines = 0
        backgroundColor = .secondarySystemBackground
    }
}
