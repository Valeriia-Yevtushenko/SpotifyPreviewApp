//
//  ArtistViewController.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 02.06.2021.
//

import UIKit

struct ArtistInfoViewModel {
    var image: String?
    var name: String?
    var tracks: [TrackTableViewCellModel]
    var albums: [TableViewCellModel]
}

enum ArtistStatus {
    case followed
    case unfollowed
    case unknown
}

final class ArtistViewController: UIViewController {
    @IBOutlet private weak var artistTableView: UITableView!
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    private let toastView = ToastView()
    var output: ArtistViewOutputProtocol?
    var dataSource: ArtistTableViewDataSource?
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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}

private extension ArtistViewController {
    func configureTableView() {
        artistTableView.delegate = dataSource
        artistTableView.dataSource = dataSource
        artistTableView.register(UINib(nibName: TrackTableViewCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier )
        artistTableView.register(UINib(nibName: TableViewCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: TableViewCell.reuseIdentifier )
        headerView = UIImageView()
        artistTableView.addSubview(headerView)
        headerView.contentMode = .scaleAspectFill
        headerView.clipsToBounds = true
        artistTableView.refreshControl = refreshControl
        artistTableView.contentInset = UIEdgeInsets(top: 400, left: 0, bottom: 0, right: 0)
        artistTableView.contentOffset = CGPoint(x: 0, y: -400)
    }
    
    func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshCollectionView(sender:)), for: .valueChanged)
    }
    
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 400)
        
        if artistTableView.contentOffset.y < UIScreen.main.bounds.width {
            headerRect.origin.y = artistTableView.contentOffset.y
            headerRect.size.height = -artistTableView.contentOffset.y
        }
        
        headerView.frame = headerRect
    }
}

extension ArtistViewController: ArtistViewInputProtocol {
    func setupArtistStatus(_ status: ArtistStatus) {
        switch status {
        case .followed:
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.badge.minus"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(unfollowButtonDidTap))
        case .unfollowed:
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.badge.plus"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(followButtonDidTap))
        case .unknown:
            break
        }
    }
    
    func setupArtistInfo(_ data: ArtistInfoViewModel) {
        dataSource?.setupData(tracks: data.tracks, albums: data.albums)
        navigationItem.title = data.name
        
        if let imageUrl = data.image {
            headerView = UIImageView()
            artistTableView.addSubview(headerView)
            headerView.setImage(withUrl: imageUrl)
            headerView.contentMode = .scaleAspectFill
            headerView.clipsToBounds = true
            updateHeaderView()
        }
    }
    
    func reloadData() {
        artistTableView.reloadData()
    }
    
    func displayLabel(with text: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        label.text = text
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.textAlignment = NSTextAlignment.center
        artistTableView.backgroundView = label
    }
    
    func showConfirmationToastView() {
        toastView.text = "Success"
        toastView.layer.setValue("0.01", forKeyPath: "transform.scale")
        toastView.alpha = 0
        view.addSubview(toastView)
        
        UIView.animate(withDuration: 1,
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
    
    func displayErrorAlert(with text: String) {
        let alert = UIAlertController(title: "Failed",
                                      message: text,
                                      preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}

extension ArtistViewController: ArtistTableViewDataSourceDelegate {
    func didSelectAlbum(at index: Int) {
        output?.viewDidTapOnAlbum(at: index)
    }
    
    func didSelectTrack(at index: Int) {
        
    }
    
    func scrollViewDidScroll() {
        updateHeaderView()
    }
}

@objc private extension ArtistViewController {
    func unfollowButtonDidTap() {
        let alert = UIAlertController(title: "Unfollow artist",
                                      message: "Are you sure you want to unfollow this artists?",
                                      preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let unfollowButton = UIAlertAction(title: "Unfollow", style: .destructive, handler: { _ in
            self.output?.viewDidTapUnfollow()
        })
        
        alert.addAction(cancelButton)
        alert.addAction(unfollowButton)
        present(alert, animated: true, completion: nil)
    }
    
    func followButtonDidTap() {
        let alert = UIAlertController(title: "Follow on artist",
                                      message: "Are you sure you want to follow this artists?",
                                      preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let followButton = UIAlertAction(title: "Follow", style: .destructive, handler: { _ in
            self.output?.viewDidTapFollow()
        })
        
        alert.addAction(cancelButton)
        alert.addAction(followButton)
        present(alert, animated: true, completion: nil)
    }
    
    func refreshCollectionView(sender: UIRefreshControl) {
        output?.viewDidRefresh()
        sender.endRefreshing()
    }
}
