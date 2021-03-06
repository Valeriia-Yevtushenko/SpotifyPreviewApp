//
//  CategoriesViewController.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import UIKit

final class CategoriesViewController: UIViewController {
    @IBOutlet private weak var categoriesCollectionView: UICollectionView!
    private var searchController: UISearchController?
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    private var loadingView: UIView?
    var output: CategoriesViewOutputProtocol?
    var dataSource: CollectionViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLoadingView()
        configureRefreshControl()
        configureCollectionView()
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewFetchData()
    }
}

private extension CategoriesViewController {
    func configureCollectionView() {
        categoriesCollectionView.dataSource = dataSource
        categoriesCollectionView.delegate = dataSource
        categoriesCollectionView.register(UINib(nibName: CollectionViewCell.reuseIdentifier, bundle: nil),
                                          forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        categoriesCollectionView.refreshControl = refreshControl
        let collectionViewLayout = categoriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.sectionInset = UIEdgeInsets(top: 5, left: 30, bottom: 5, right: 30)
        collectionViewLayout?.minimumInteritemSpacing = 20
        collectionViewLayout?.minimumLineSpacing = 20
        collectionViewLayout?.invalidateLayout()
    }
    
    func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshCollectionView(sender:)), for: .valueChanged)
    }
    
    func addLoadingView() {
        let allViewsInXibArray = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        loadingView = allViewsInXibArray?.first as? UIView
        self.view.addSubview(loadingView!)
    }
    
    @objc func refreshCollectionView(sender: UIRefreshControl) {
        output?.viewDidRefresh()
        sender.endRefreshing()
    }
}

extension CategoriesViewController: CategoriesViewInputProtocol {
    func setupData(_ model: [CollectionViewCellModel]) {
        loadingView?.removeFromSuperview()
        dataSource?.setupViewModel(model)
        categoriesCollectionView.backgroundView = nil
    }
    
    func configureSearchController(searchResultsController: Presentable?) {
        guard let searchViewController = searchResultsController as? UIViewController else {
            return
        }

        searchController = UISearchController(searchResultsController: searchViewController)
        searchController?.searchResultsUpdater = searchViewController as? UISearchResultsUpdating
        searchController?.hidesNavigationBarDuringPresentation = true
        searchController?.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
    }
    
    func displayLabel(with text: String) {
        loadingView?.removeFromSuperview()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        label.text = text
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        categoriesCollectionView.backgroundView = label
    }
    
    func reloadData() {
        categoriesCollectionView.reloadData()
    }
}

extension CategoriesViewController: CollectionViewDataSourceDelegate {
    func didSelectItem(at index: Int) {
        output?.viewSelectedItem(at: index)
    }
}
