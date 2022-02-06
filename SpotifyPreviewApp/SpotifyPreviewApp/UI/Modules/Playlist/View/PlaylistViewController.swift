//
//  PlaylistViewController.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import UIKit

class PlaylistViewController: UIViewController {
    @IBOutlet private weak var playlistTableView: UITableView!
    var output: PlaylistViewOutputProtocol?
    var dataSource: TrackTableViewDataSource?
    var headerView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        output?.viewWillDisappear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
        headerView = UIImageView()
        headerView.contentMode = .scaleAspectFill
        headerView.clipsToBounds = true
        playlistTableView.contentInset = UIEdgeInsets(top: 400, left: 0, bottom: 0, right: 0)
        playlistTableView.contentOffset = CGPoint(x: 0, y: -400)
        updateHeaderView()
    }
}

extension PlaylistViewController: PlaylistViewInputProtocol {
    func setupPlaylistInfo(image url: String?, name: String?, type: PlaylistType) {
        navigationItem.title = name
        
        if let url = url {
            headerView.setImage(withUrl: url)
            playlistTableView.addSubview(headerView)
        }
        
        switch type {
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
    
    func setupPlaylistTracks(_ tracks: [TrackTableViewCellModel]) {
        playlistTableView.backgroundView = tracks.isEmpty ? playlistTableView.backgroundView: nil
        dataSource?.setupViewModel(tracks)
    }
    
    func reloadData() {
        playlistTableView.reloadData()
    }
    
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 400)
        
        if playlistTableView.contentOffset.y < UIScreen.main.bounds.width {
            headerRect.origin.y = playlistTableView.contentOffset.y
            headerRect.size.height = -playlistTableView.contentOffset.y
        }
        
        headerView.frame = headerRect

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
    func scrollViewDidScroll() {
        output?.viewDidUpdate()
    }
}

@objc private extension PlaylistViewController {
    func addButtonDidTap() {
    
    }
    
    func trashButtonDidTap() {
        output?.viewDidTapDeletePlaylist()
    }
    
    func editButtonDidTap() {
    
    }
}
