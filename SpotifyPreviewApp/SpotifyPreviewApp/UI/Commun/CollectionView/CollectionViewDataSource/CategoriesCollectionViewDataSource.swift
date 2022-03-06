//
//  CollectionViewDataSource.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import UIKit

protocol CollectionViewDataSourceDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

final class CollectionViewDataSource: NSObject {
    private var categories: [CollectionViewCellModel] = []
    weak var delegate: CollectionViewDataSourceDelegate?
}

extension CollectionViewDataSource {
    func setupViewModel(_ model: [CollectionViewCellModel]) {
        categories = model
    }
}
extension CollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.size.width / 2.8
        return CGSize(width: size, height: size)
    }
}

extension CollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }
}

extension CollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setupCell(categories[indexPath.row])
        return cell
    }
}
