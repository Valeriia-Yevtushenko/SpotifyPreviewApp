//
//  AlbumTableViewCell.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import UIKit

struct AlbumTableViewCellModel {
    var imageUrl: String?
    var name: String?
}

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.albumImageView.image = nil
        self.nameLabel.text = nil
    }

    func configure(_ model: AlbumTableViewCellModel) {
        albumImageView.layer.cornerRadius = .pi
        nameLabel.text = model.name
        
        if let image = model.imageUrl {
            albumImageView.setImage(withUrl: image)
        }
    }
}

private extension AlbumTableViewCell {
    @IBAction func shuffleButtonDidTap() {
        
    }
    
    @IBAction func playButtonDidTap() {
        
    }
}
