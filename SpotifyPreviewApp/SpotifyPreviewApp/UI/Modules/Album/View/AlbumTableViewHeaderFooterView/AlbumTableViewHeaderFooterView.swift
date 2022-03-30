//
//  AlbumTableViewCell.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import UIKit

struct AlbumTableViewHeaderFooterViewModel {
    var imageUrl: String?
    var name: String?
}

class AlbumTableViewHeaderFooterView: UITableViewHeaderFooterView {
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    var play: (() -> Void)!
    var shuffle: (() -> Void)!
    
    func configure(_ model: AlbumTableViewHeaderFooterViewModel?) {
        albumImageView.layer.cornerRadius = .pi
        nameLabel.text = model?.name
        
        if let image = model?.imageUrl {
            albumImageView.setImage(withUrl: image)
        }
    }
}

private extension AlbumTableViewHeaderFooterView {
    @IBAction func shuffleButtonDidTap() {
        shuffle()
    }
    
    @IBAction func playButtonDidTap() {
        play()
    }
}
