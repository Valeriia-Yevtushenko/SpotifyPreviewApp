//
//  TableViewCell.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import UIKit

struct TrackTableViewCellModel {
    var name: String?
    var artist: String?
    var image: String?
    var imageData: Data?
}

final class TrackTableViewCell: UITableViewCell {
    @IBOutlet private weak var cellImageView: CustomImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.cellImageView.image = nil
        self.nameLabel.text = nil
        self.artistLabel.text = nil
    }
    
    func configure(_ model: TrackTableViewCellModel) {
        if let image = model.image {
            cellImageView.loadImageUsingUrlString(urlString: image)
        } else if let data = model.imageData {
            cellImageView.image = UIImage(data: data)
        }
        
        nameLabel.text = model.name
        artistLabel.text = model.artist
        artistLabel.isUserInteractionEnabled = true
    }
}
