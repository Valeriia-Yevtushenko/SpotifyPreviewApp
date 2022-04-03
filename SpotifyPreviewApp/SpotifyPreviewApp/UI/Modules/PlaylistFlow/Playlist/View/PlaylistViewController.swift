//
//  PlaylistViewController.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import UIKit

struct PlaylistViewControllerModel {
    var name: String?
    var type: PlaylistType
    var imageUrl: String?
}

class PlaylistViewController: UIViewController {
    @IBOutlet private weak var playlistTableView: UITableView!
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    private let toastView = ToastView()
    var output: PlaylistViewOutputProtocol?
    var dataSource: PlaylistTableViewDataSource?
    var headerView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewDidLoad()
        configureTableView()
        configureRefreshControl()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        output?.viewWillAppear()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}

private extension PlaylistViewController {
    func configureTableView() {
        playlistTableView.dataSource = dataSource
        playlistTableView.delegate = dataSource
        playlistTableView.register(UINib(nibName: PlaylistTableViewHeaderFooterView.reuseIdentifier,
                                         bundle: nil),
                                   forHeaderFooterViewReuseIdentifier: PlaylistTableViewHeaderFooterView.reuseIdentifier)
        playlistTableView.register(UINib(nibName: TrackTableViewCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier )
        playlistTableView.refreshControl = refreshControl
        headerView = UIImageView()
        headerView.contentMode = .scaleAspectFill
        headerView.clipsToBounds = true
        playlistTableView.contentInset = UIEdgeInsets(top: 400, left: 0, bottom: 0, right: 0)
        playlistTableView.contentOffset = CGPoint(x: 0, y: -400)
        updateHeaderView()
    }
    
    func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshCollectionView(sender:)), for: .valueChanged)
    }
    
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 400)
        
        if playlistTableView.contentOffset.y < UIScreen.main.bounds.width {
            headerRect.origin.y = playlistTableView.contentOffset.y
            headerRect.size.height = -playlistTableView.contentOffset.y
        }
        
        headerView.frame = headerRect
    }
}

@objc private extension PlaylistViewController {
    func addButtonDidTap() {
        let alert = UIAlertController(title: "Add playlist",
                                      message: "Are you sure you want to add this playlist to favorites?",
                                      preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteButton = UIAlertAction(title: "Add", style: .destructive, handler: { _ in
            self.output?.viewDidTapAddPlaylist()
        })
        
        alert.addAction(cancelButton)
        alert.addAction(deleteButton)
        present(alert, animated: true, completion: nil)
    }
    
    func trashButtonDidTap() {
        let alert = UIAlertController(title: "Delete playlist",
                                      message: "Are you sure you want to delete the playlist? After that you won't be able to restore it.",
                                      preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.output?.viewDidTapDeletePlaylist()
        })
        
        alert.addAction(cancelButton)
        alert.addAction(deleteButton)
        present(alert, animated: true, completion: nil)
    }
    
    func editButtonDidTap() {
        output?.viewDidEditPlaylist()
    }
    
    func refreshCollectionView(sender: UIRefreshControl) {
        output?.viewDidRefresh()
        sender.endRefreshing()
    }
}

extension PlaylistViewController: PlaylistViewInputProtocol {
    func shareURL(_ url: String) {
        let url = URL(string: url)
        let activity = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activity, animated: true)
    }
    
    func setupPlaylist(model: PlaylistViewControllerModel, tracks: [TrackTableViewCellModel]) {
        navigationItem.title = model.name
        playlistTableView.backgroundView = tracks.isEmpty ? playlistTableView.backgroundView: nil
        dataSource?.setupViewModel(tracks, type: model.type)
        
        if let url = model.imageUrl {
            headerView.setImage(withUrl: url)
            playlistTableView.addSubview(headerView)
        }
        
        switch model.type {
        case .user:
            navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .trash,
                                                                  target: self,
                                                                  action: #selector(trashButtonDidTap)),
                                                  UIBarButtonItem(barButtonSystemItem: .compose,
                                                                  target: self,
                                                                  action: #selector(editButtonDidTap))]
        case .category(_):
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonDidTap))
        }
    }
    
    func showConfirmationToastView(with text: String) {
        toastView.text = text
        toastView.layer.setValue("0.01", forKeyPath: "transform.scale")
        toastView.alpha = 0
        view.addSubview(toastView)
        
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 0,
                       options: [.beginFromCurrentState],
                       animations: {
            self.toastView.alpha = 1
            self.toastView.layer.setValue(1, forKeyPath: "transform.scale")
            }) { _ in
                self.toastView.removeFromSuperview()
            }
    }
    
    func reloadData() {
        playlistTableView.reloadData()
    }
    
    func displayLabel(with text: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        label.text = text
        label.textColor = .lightGray
        label.textAlignment = NSTextAlignment.center
        playlistTableView.backgroundView = label
    }
    
    func displayErrorAlert(with text: String) {
        let alert = UIAlertController(title: "Failed",
                                      message: text,
                                      preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}

extension PlaylistViewController: PlaylistTableViewDataSourceDelegate {
    func didTapDeleteItem(at index: Int) {
        let alert = UIAlertController(title: "Are you sure you want to delete the track?",
                                      message: "If you delete it, you won't be able to restore it.",
                                      preferredStyle: .alert)
        let deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.output?.viewDidTapDeleteItem(at: index)
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(deleteButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
    func didTapShowItemArtist(at index: Int) {
        output?.viewDidTapShowItemArtist(at: index)
    }
    
    func didTapShowItemAlbum(at index: Int) {
        output?.viewDidTapShowItemAlbum(at: index)
    }
    
    func didTapAddToPlaylist(at index: Int) {
        output?.viewDidTapAddItemToPlaylist(at: index)
    }
    
    func didTapShare(at index: Int) {
        output?.viewDidTapShareItem(at: index)
    }
    
    func didTapDownload(at index: Int) {
        output?.viewDidTapDownloadItem(at: index)
    }
    
    func didTapPlay() {
        output?.viewDidTapPlay()
    }
    
    func didTapShuffle() {
        output?.viewDidTapShuffle()
    }
    
    func didSelectItem(at index: Int) {
        output?.viewDidSelectItem(at: index)
    }
    
    func scrollViewDidScroll() {
        updateHeaderView()
    }
}
