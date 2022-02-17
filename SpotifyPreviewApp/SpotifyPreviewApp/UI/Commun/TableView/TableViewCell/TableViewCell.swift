//
//  TableViewCell.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 01.06.2021.
//

import UIKit

struct TableViewCellModel {
    var name: String?
    var image: String?
}

final class TableViewCell: UITableViewCell {
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellImageView.image = nil
        self.nameLabel.text = nil
    }
    
    func configure(_ model: TableViewCellModel) {
        cellImageView.layer.cornerRadius = .pi
        nameLabel.text = model.name
        
        guard let image = model.image else {
            return
        }
        
        cellImageView.setImage(withUrl: image)
    }
}
