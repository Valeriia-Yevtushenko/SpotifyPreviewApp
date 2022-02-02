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
    
    var output: ProfileViewOutputProtocol?
    var dataSource: TableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewDidLoad()
    }
}

private extension ProfileViewController {
    @IBAction func logOutButtonDidTap() {
        output?.logOut()
    }
}

extension ProfileViewController: ProfileViewInputProtocol {
    func displayErrorView() {
        
    }
    
    func configureProfileInfo(_ model: ProfileInfoModel) {
        userEmailLabel.text = model.userEmail
        usernameLabel.text = model.username
        userImageView.setImage(withUrl: model.userImage ?? "")
    }
    
    func reloadData() {
       
    }
}

extension ProfileViewController: TableViewDataSourceDelegate {
    func didSelectItem(at index: Int) {
        
    }
}
