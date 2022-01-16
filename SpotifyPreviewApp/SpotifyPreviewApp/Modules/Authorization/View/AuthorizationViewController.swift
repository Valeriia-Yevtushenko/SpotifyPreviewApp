//
//  ViewController.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 15.01.2022.
//

import UIKit

class AuthorizationViewController: UIViewController {
    var output: AuthorizationViewOutputProtocol?

    @IBAction func authorizationButtonDidTap() {
        output?.viewDidTapButton()
    }
}

extension AuthorizationViewController: AuthorizationViewInputProtocol {
    func displayErrorAlert() {
        let alert = UIAlertController(title: "Authorization error", message: nil, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}
