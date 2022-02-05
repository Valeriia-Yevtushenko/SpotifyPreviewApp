//
//  PlaylistsViewController.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import UIKit

enum PlaylistType {
    case user
    case category(String)
}

final class ListOfPlaylistsViewController: UIViewController {
    @IBOutlet weak var playlistCollectionView: UICollectionView!
    var output: ListOfPlaylistsViewOutputProtocol?
    var dataSource: CollectionViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        configureCollectionView()
    }
}

private extension ListOfPlaylistsViewController {
    func configureCollectionView() {
        playlistCollectionView.dataSource = dataSource
        playlistCollectionView.delegate = dataSource
        playlistCollectionView.register(UINib(nibName: CollectionViewCell.reuseIdentifier, bundle: nil),
                                        forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        let collectionViewLayout = playlistCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.sectionInset = UIEdgeInsets(top: 5, left: 30, bottom: 5, right: 30)
        collectionViewLayout?.minimumInteritemSpacing = 20
        collectionViewLayout?.minimumLineSpacing = 20
        collectionViewLayout?.invalidateLayout()
    }
}

extension ListOfPlaylistsViewController: ListOfPlaylistsViewInputProtocol {
    func setupPlaylistsType(_ type: PlaylistType) {
        switch type {
        case .user:
            navigationItem.title = "Your playlists"
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonDidTap))
        case .category(let name):
            navigationItem.title = name.uppercased()
        }
    }
    
    func setupData(_ model: [CollectionViewCellModel]) {
        dataSource?.setupViewModel(model)
    }
    
    func reloadData() {
        playlistCollectionView.reloadData()
    }
    
    func displayLabel(with text: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        label.text = text
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.textAlignment = NSTextAlignment.center
        playlistCollectionView.backgroundView = label
    }
}

extension ListOfPlaylistsViewController: CollectionViewDataSourceDelegate {
    func didSelectItem(at index: Int) {
        output?.viewSelectedItem(at: index)
    }
}

@objc private extension ListOfPlaylistsViewController {
    func addButtonDidTap() {
        let alert = UIAlertController(title: "Create new playlist",
                                      message: "Please, enter playlist name and description.",
                                      preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let createButton = UIAlertAction(title: "Create", style: .destructive, handler: { [weak alert] (_) in
            self.output?
                .viewDidTapCreatePlaylist(NewPlaylist(name: alert?.textFields?[0].text ?? "",
                                                      description: alert?.textFields?[1].text ?? "", publicType: false))
        })
        
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Description"
        }
        
        alert.addAction(cancelButton)
        alert.addAction(createButton)
        present(alert, animated: true, completion: nil)
    }
}
