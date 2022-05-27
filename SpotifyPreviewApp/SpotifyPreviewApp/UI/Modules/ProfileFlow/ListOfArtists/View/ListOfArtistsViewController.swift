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
    private var loadingView: UIView?
    var output: ListOfArtistsViewOutputProtocol?
    var dataSource: ArtistsTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Follows"
        addLoadingView()
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
    
    func addLoadingView() {
        let allViewsInXibArray = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        loadingView = allViewsInXibArray?.first as? UIView
        self.view.addSubview(loadingView!)
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
        loadingView?.removeFromSuperview()
        dataSource?.setupViewModel(model)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func displayLabel(with text: String) {
        loadingView?.removeFromSuperview()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        label.text = text
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.textAlignment = NSTextAlignment.center
        tableView.backgroundView = label
    }
}

extension ListOfArtistsViewController: ArtistsTableViewDataSourceDelegate {
    func didSelectItem(at index: Int) {
        output?.viewSelectedItem(at: index)
    }
}
