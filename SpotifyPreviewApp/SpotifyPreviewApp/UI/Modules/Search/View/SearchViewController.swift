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
    var dataSource: TrackTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}
private extension SearchViewController {
    func configureTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.register(UINib(nibName: TrackTableViewCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier )
    }
}

extension SearchViewController: SearchViewInputProtocol {
    func setupData(_ tracks: [TrackTableViewCellModel]) {
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
