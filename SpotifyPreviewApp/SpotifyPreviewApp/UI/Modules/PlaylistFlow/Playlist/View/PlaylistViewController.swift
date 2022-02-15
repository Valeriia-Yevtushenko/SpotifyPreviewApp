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
    var dataSource: TrackTableViewDataSource?
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

extension PlaylistViewController: PlaylistViewInputProtocol {
    func setupPlaylist(model: PlaylistViewControllerModel, tracks: [TrackTableViewCellModel]) {
        navigationItem.title = model.name
        playlistTableView.backgroundView = tracks.isEmpty ? playlistTableView.backgroundView: nil
        dataSource?.setupViewModel(tracks)
        
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
    
    func showConfirmationToastView() {
        toastView.text = "Successfully added"
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

extension PlaylistViewController: TrackTableViewDataSourceDelegate {
    func trackArtistDidTap(at index: Int) {
        output?.viewDidTapOnTrackArtist(at: index)
    }
    
    func scrollViewDidScroll() {
        updateHeaderView()
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
