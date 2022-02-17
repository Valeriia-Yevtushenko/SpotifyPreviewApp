//
//  TableViewCell.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import UIKit

struct TrackTableViewCellModel {
    var image: String?
    var name: String?
    var artist: String?
}

final class TrackTableViewCell: UITableViewCell {
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    let tapGesture = UITapGestureRecognizer()
    var artistDidTap: (() -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.cellImageView.image = nil
        self.nameLabel.text = nil
        self.artistLabel.text = nil
        self.artistDidTap = nil
    }
    
    func configure(_ model: TrackTableViewCellModel) {
        if let image = model.image {
            cellImageView.setImage(withUrl: image)
        }
        
        nameLabel.text = model.name
        artistLabel.text = model.artist
        tapGesture.addTarget(self, action: #selector(artistLabelDidTap(_:)))
        artistLabel.isUserInteractionEnabled = true
        artistLabel.addGestureRecognizer(tapGesture)
    }
}

@objc private extension TrackTableViewCell {
    func artistLabelDidTap(_ sender: UITapGestureRecognizer) {
        guard let action = artistDidTap else {
            return
        }
        
        action()
    }
}
