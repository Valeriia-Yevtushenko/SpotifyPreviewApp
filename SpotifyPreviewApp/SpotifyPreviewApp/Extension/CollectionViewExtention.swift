//
//  CollectionViewExtention.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }

        return cell
    }
}
