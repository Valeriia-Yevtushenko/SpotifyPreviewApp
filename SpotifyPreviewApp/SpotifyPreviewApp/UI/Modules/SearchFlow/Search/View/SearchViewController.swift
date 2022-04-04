//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 17.05.2021.
//

import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    var output: SearchViewOutputProtocol?
    var dataSource: SearchTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}
private extension SearchViewController {
    func configureTableView() {
        dataSource?.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.register(UINib(nibName: TrackTableViewCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier )
    }
}

extension SearchViewController: SearchViewInputProtocol {
    func shareURL(_ url: String) {
        let url = URL(string: url)
        let activity = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activity, animated: true)
    }
    
    func setupData(_ tracks: [TrackTableViewCellModel]) {
        tableView.backgroundView = nil
        dataSource?.setupViewModel(tracks)
    }
    
    func displayLabel(with text: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        label.text = text
        label.textColor = .lightGray
        label.textAlignment = NSTextAlignment.center
        tableView.backgroundView = label
    }

    func reloadData() {
        tableView.reloadData()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        if !text.isEmpty {
            output?.viewDidUpdateBySearchText(text)
        }
    }
}

extension SearchViewController: SearchTableViewDataSourceDelegate {
    func didTapShareItem(at index: Int) {
        output?.viewDidTapShareItem(at: index)
    }
    
    func didTapAddItemToPlaylist(at index: Int) {
        output?.viewDidTapAddItemToPlaylist(at: index)
    }
    
    func didTapDownloadItem(at index: Int) {
        output?.viewDidTapDownloadItem(at: index)
    }
    
    func didTapShowItemArtist(at index: Int) {
        output?.viewDidTapShowItemArtist(at: index)
    }
    
    func didTapShowItemAlbum(at index: Int) {
        output?.viewDidTapShowItemAlbum(at: index)
    }
    
    func didSelectItem(at index: Int) {
        output?.viewDidSelectItem(at: index)
    }
}
