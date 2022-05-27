//
//  SavedTracksViewController.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 05.04.2022.
//

import UIKit

class SavedTracksViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    var dataSource: SavedTracksTableViewDataSource?
    var output: SavedTracksViewOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        output?.viewDidLoad()
    }
}

private extension SavedTracksViewController {
    func configureTableView() {
        dataSource?.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.register(UINib(nibName: PlaylistTableViewHeaderFooterView.reuseIdentifier,
                                         bundle: nil),
                                   forHeaderFooterViewReuseIdentifier: PlaylistTableViewHeaderFooterView.reuseIdentifier)
        tableView.register(UINib(nibName: TrackTableViewCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier )
    }
}

extension SavedTracksViewController: SavedTracksViewInputProtocol {
    func setupData(_ tracks: [TrackTableViewCellModel]) {
        tableView.backgroundView = nil
        dataSource?.setupViewModel(tracks)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func displayLabel(with text: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        label.text = text
        label.textColor = .lightGray
        label.textAlignment = NSTextAlignment.center
        tableView.backgroundView = label
    }
    
    func shareURL(_ url: String) {
        let url = URL(string: url)
        let activity = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activity, animated: true)
    }
}

extension SavedTracksViewController: SavedTracksTableViewDataSourceDelegate {
    func didTapPlay() {
        output?.viewDidTapPlay()
    }
    
    func didTapShuffle() {
        output?.viewDidTapShuffle()
    }
    
    func didSelectItem(at index: Int) {
        output?.viewDidSelectItem(at: index)
    }
    
    func didTapShareItem(at index: Int) {
        output?.viewDidTapShareItem(at: index)
    }
    
    func didTapAddItemToPlaylist(at index: Int) {
        output?.viewDidTapAddItemToPlaylist(at: index)
    }
    
    func didTapShowItemArtist(at index: Int) {
        output?.viewDidTapShowItemArtist(at: index)
    }
    
    func didTapShowItemAlbum(at index: Int) {
        output?.viewDidTapShowItemAlbum(at: index)
    }
}
