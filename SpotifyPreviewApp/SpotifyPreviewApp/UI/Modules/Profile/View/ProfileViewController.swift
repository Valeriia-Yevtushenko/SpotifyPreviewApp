//
//  ProfileViewController.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 17.05.2021.
//

import UIKit

struct ProfileInfoModel {
    var userImage: String?
    var username: String?
    var userEmail: String?
}

final class ProfileViewController: UIViewController {
    @IBOutlet private weak var userEmailLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var followsView: UIView!
    @IBOutlet private weak var playlistView: UIView!
    @IBOutlet private weak var albumsView: UIView!
    @IBOutlet private weak var userImageHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var userImageWidthLayoutConstraint: NSLayoutConstraint!
    
    var output: ProfileViewOutputProtocol?
    var dataSource: TableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewDidLoad()
        configure()
    }
}

private extension ProfileViewController {
    @IBAction func logOutButtonDidTap() {
        output?.viewDidTapLogOut()
    }
    
    func configure() {
        navigationController?.navigationBar.isHidden = true
        userImageWidthLayoutConstraint.constant = self.view.frame.width / 2
        userImageHeightLayoutConstraint.constant = self.view.frame.width / 2
        userImageView.layer.cornerRadius = userImageWidthLayoutConstraint.constant / 2
        userImageView.clipsToBounds = true
        setupTopBorder(followsView)
        setupBottomBorder(playlistView)
        setupBottomBorder(followsView)
        setupBottomBorder(albumsView)
    }
    
    func setupTopBorder(_ view: UIView) {
        let thickness: CGFloat = 1
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0.0,
                                 y: 0.0,
                                 width: self.view.frame.size.width,
                                 height: thickness)
        topBorder.backgroundColor = UIColor.separator.cgColor
        view.layer.addSublayer(topBorder)
    }
    
    func setupBottomBorder(_ view: UIView) {
        let thickness: CGFloat = 1
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0,
                                    y: view.frame.size.height - thickness,
                                    width: self.view.frame.size.width,
                                    height: thickness)
        bottomBorder.backgroundColor = UIColor.separator.cgColor
        view.layer.addSublayer(bottomBorder)
    }
    
    func displayErrorAlert() {
        let alert = UIAlertController(title: "Oops, something went wrong",
                                      message: "Please, check your internet conection and reload view.",
                                      preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let tryAgainButton = UIAlertAction(title: "Reload", style: .default, handler: { _ in
            self.output?.viewDidTapReload()
        })
        alert.addAction(cancelButton)
        alert.addAction(tryAgainButton)
        present(alert, animated: true, completion: nil)
    }
}

extension ProfileViewController: ProfileViewInputProtocol {
    func handleError() {
        usernameLabel.text = nil
        userEmailLabel.text = nil
    }
    
    func configureProfileInfo(_ model: ProfileInfoModel) {
        userEmailLabel.text = model.userEmail
        usernameLabel.text = model.username
        userImageView.setImage(withUrl: model.userImage ?? "")
    }
}

extension ProfileViewController: TableViewDataSourceDelegate {
    func didSelectItem(at index: Int) {
        output?.viewDidSelectedItem(at: index)
    }
}
