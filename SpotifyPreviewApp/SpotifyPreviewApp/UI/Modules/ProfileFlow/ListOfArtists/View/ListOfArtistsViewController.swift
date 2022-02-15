//
//  ListOfArtistsViewController.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import UIKit

class ListOfArtistsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    var output: ListOfArtistsViewOutputProtocol?
    var dataSource: TableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Follows"
        output?.viewDidLoad()
        configureRefreshControl()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        output?.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
}

private extension ListOfArtistsViewController {
    func configureTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.register(UINib(nibName: TableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        tableView.refreshControl = refreshControl
    }
    
    func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshCollectionView(sender:)), for: .valueChanged)
    }
}

@objc private extension ListOfArtistsViewController {
    func refreshCollectionView(sender: UIRefreshControl) {
        output?.viewDidRefresh()
        sender.endRefreshing()
    }
}

extension ListOfArtistsViewController: ListOfArtistsViewInputProtocol {
    func setupData(_ model: [TableViewCellModel]) {
        dataSource?.setupViewModel(model)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func displayLabel(with text: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        label.text = text
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.textAlignment = NSTextAlignment.center
        tableView.backgroundView = label
    }
}

extension ListOfArtistsViewController: TableViewDataSourceDelegate {
    func didSelectItem(at index: Int) {
        output?.viewSelectedItem(at: index)
    }
}
