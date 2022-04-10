//
//  PlaylistsViewController.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import UIKit
import SwiftUI

enum PlaylistType: Equatable {
    case user
    case category(String)
}

final class ListOfPlaylistsViewController: UIViewController {
    @IBOutlet private weak var playlistCollectionView: UICollectionView!
    @IBOutlet private weak var accessoryView: UIView!
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    private let toastView = ToastView()
    private var loadingView: UIView?
    var output: ListOfPlaylistsViewOutputProtocol?
    var dataSource: CollectionViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLoadingView()
        output?.viewDidLoad()
        configureAccessoryView()
        configureCollectionView()
        configureRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output?.viewWillAppear()
    }
}

private extension ListOfPlaylistsViewController {
    func configureCollectionView() {
        playlistCollectionView.dataSource = dataSource
        playlistCollectionView.delegate = dataSource
        playlistCollectionView.register(UINib(nibName: CollectionViewCell.reuseIdentifier, bundle: nil),
                                        forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        playlistCollectionView.refreshControl = refreshControl
        let collectionViewLayout = playlistCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 5, right: 30)
        collectionViewLayout?.minimumInteritemSpacing = 20
        collectionViewLayout?.minimumLineSpacing = 20
        collectionViewLayout?.invalidateLayout()
    }
    
    func configureAccessoryView() {
        if isModal {
            accessoryView.layer.cornerRadius = .pi
        } else {
            accessoryView.isHidden = true
        }
    }
    
    func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshCollectionView(sender:)), for: .valueChanged)
    }
    
    func addLoadingView() {
        let allViewsInXibArray = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        loadingView = allViewsInXibArray?.first as? UIView
        self.view.addSubview(loadingView!)
    }
}

extension ListOfPlaylistsViewController: ListOfPlaylistsViewInputProtocol {
    func showToastView(with text: String) {
        toastView.text = "Successfully added to \(text)"
        toastView.layer.setValue("0.01", forKeyPath: "transform.scale")
        toastView.alpha = 0
        view.addSubview(toastView)
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 0,
                       options: [.beginFromCurrentState],
                       animations: {
            self.toastView.alpha = 1
            self.toastView.layer.setValue(1, forKeyPath: "transform.scale")
            }) { _ in
                self.toastView.removeFromSuperview()
                self.output?.viewDismiss()
            }
    }
    
    func setupData(_ model: [CollectionViewCellModel], type: PlaylistType) {
        loadingView?.removeFromSuperview()
        dataSource?.setupViewModel(model)
        playlistCollectionView.backgroundView = model.isEmpty ? playlistCollectionView.backgroundView: nil
        
        switch type {
        case .user:
            navigationItem.title = "Your playlists"
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonDidTap))
        case .category(let name):
            navigationItem.title = name.uppercased()
        }
    }
    
    func reloadData() {
        playlistCollectionView.reloadData()
    }
    
    func displayLabel(with text: String) {
        loadingView?.removeFromSuperview()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        label.text = text
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.textAlignment = NSTextAlignment.center
        playlistCollectionView.backgroundView = label
    }
    
    func displayErrorAlert(title: String, text: String) {
        let alert = UIAlertController(title: title,
                                      message: text,
                                      preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            if self.isModal {
                self.output?.viewDismiss()
            }
        }
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}

extension ListOfPlaylistsViewController: CollectionViewDataSourceDelegate {
    func didSelectItem(at index: Int) {
        output?.viewSelectedItem(at: index)
    }
}

@objc private extension ListOfPlaylistsViewController {
    func refreshCollectionView(sender: UIRefreshControl) {
        output?.viewDidRefresh()
        sender.endRefreshing()
    }
    
    func addButtonDidTap() {
        let alert = UIAlertController(title: "Create new playlist",
                                      message: "Please, enter playlist name and description.",
                                      preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let createButton = UIAlertAction(title: "Create", style: .destructive, handler: { [weak alert] (_) in
            self.output?
                .viewDidTapCreatePlaylist(NewPlaylist(name: alert?.textFields?[0].text ?? "",
                                                      description: alert?.textFields?[1].text ?? "", isPublic: false))
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
