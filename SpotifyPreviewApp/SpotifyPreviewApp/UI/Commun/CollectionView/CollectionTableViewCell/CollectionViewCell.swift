//
//  CollectionViewCell.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import UIKit

struct CollectionViewCellModel {
    var image: String?
    var name: String?
}

final class CollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        cellImageView.image = nil
        nameLabel.text = nil
    }
    
    func setupCell(_ data: CollectionViewCellModel) {
        cellImageView.layer.cornerRadius = 10
        
        guard let imageData = data.image else {
            cellImageView.image = UIImage(systemName: "music.note.list")?.withRenderingMode(.alwaysOriginal)
            cellImageView.backgroundColor = .placeholderText
            nameLabel.text = data.name
            return
        }
        
        cellImageView.setImage(withUrl: imageData)
        nameLabel.text = data.name
    }
}
