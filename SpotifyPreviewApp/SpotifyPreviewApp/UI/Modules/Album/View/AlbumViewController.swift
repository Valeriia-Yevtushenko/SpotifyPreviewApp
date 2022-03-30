//
//  AlbumViewController.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import UIKit

class AlbumViewController: UIViewController {
    @IBOutlet private weak var albumTableView: UITableView!
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    var output: AlbumViewOutputProtocol?
    var dataSource: AlbumTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewDidLoad()
        configureTableView()
        configureRefreshControl()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        output?.viewWillDisappear()
    }
}

private extension AlbumViewController {
    func configureTableView() {
        albumTableView.dataSource = dataSource
        albumTableView.delegate = dataSource
        albumTableView.register(UINib(nibName: AlbumTableViewHeaderFooterView.reuseIdentifier,
                                      bundle: nil), forHeaderFooterViewReuseIdentifier: AlbumTableViewHeaderFooterView.reuseIdentifier)
        albumTableView.register(UINib(nibName: TrackTableViewCell.reuseIdentifier, bundle: nil),
                                forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier)
        albumTableView.refreshControl = refreshControl
        dataSource?.delegate = self
    }
    
    func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshCollectionView(sender:)), for: .valueChanged)
    }
}

@objc private extension AlbumViewController {
    func refreshCollectionView(sender: UIRefreshControl) {
        output?.viewDidRefresh()
        sender.endRefreshing()
    }
}

extension AlbumViewController: AlbumTableViewDataSourceDelegate {
    func playDidTap() {
        output?.viewDidTapPlay()
    }
    
    func shuffleDidTap() {
        output?.viewDidTapShuffle()
    }
    
    func didSelectItem(at index: Int) {
        output?.viewSelectedItem(at: index)
    }
}

extension AlbumViewController: AlbumViewInputProtocol {
    func setupData(_ info: AlbumTableViewHeaderFooterViewModel, tracks: [TrackTableViewCellModel]) {
        dataSource?.setupData(tracks: tracks, album: info)
    }
    
    func reloadData() {
        albumTableView.reloadData()
    }
    
    func displayLabel(with text: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        label.text = text
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.textAlignment = NSTextAlignment.center
        albumTableView.backgroundView = label
    }
}
