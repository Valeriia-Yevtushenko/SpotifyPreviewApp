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
    @IBOutlet private weak var userImageView: CustomImageView!
    @IBOutlet private weak var followsView: UIView!
    @IBOutlet private weak var playlistView: UIView!
    @IBOutlet private weak var savedTracksView: UIView!
    @IBOutlet private weak var userImageHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var userImageWidthLayoutConstraint: NSLayoutConstraint!
    
    var output: ProfileViewOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewDidLoad()
        configureUserImageView()
        configureSections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
}

private extension ProfileViewController {
    @IBAction func savedTracksSectionDidSelect(_ sender: UITapGestureRecognizer) {
        output?.viewDidTapOnSavedTracksSection()
    }
    
    @IBAction func followsSectionDidSelect(_ sender: UITapGestureRecognizer) {
        output?.viewDidTapOnFollowsSection()
    }
    
    @IBAction func playlistsSectionDidSelected(_ sender: UITapGestureRecognizer) {
        output?.viewDidTapOnPlaylistsSection()
    }
    
    @IBAction func logOutButtonDidTap() {
        output?.viewDidTapLogOut()
    }
    
    func configureUserImageView() {
        userImageWidthLayoutConstraint.constant = self.view.frame.width / 2
        userImageHeightLayoutConstraint.constant = self.view.frame.width / 2
        userImageView.layer.cornerRadius = userImageWidthLayoutConstraint.constant / 2
        userImageView.clipsToBounds = true
    }
    
    func configureSections() {
        setupTopBorder(followsView)
        setupBottomBorder(playlistView)
        setupBottomBorder(savedTracksView)
        setupBottomBorder(followsView)
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
        guard let url = model.userImage else {
            userImageView.image = UIImage(systemName: "person.circle")
            return
        }
        
        userImageView.loadImageUsingUrlString(urlString: url)
    }
}
