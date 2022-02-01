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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellImageView.image = nil
        self.nameLabel.text = nil
        self.artistLabel.text = nil
    }

    func configure(_ model: TrackTableViewCellModel) {
        guard let image = model.image else {
            return
        }
        
        cellImageView.setImage(withUrl: image)
        nameLabel.text = model.name
        artistLabel.text = model.artist
    }
}
