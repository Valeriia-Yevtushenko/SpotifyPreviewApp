//
//  EditPlaylistViewController.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 06.02.2022.
//

import UIKit
import PromiseKit

struct EditPlaylistViewControllerViewModel {
    var name: String
    var description: String?
    var image: Data?
}

class EditPlaylistViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

private extension EditPlaylistViewController {
    @IBAction func changeImageButtonDidTap() {
       
    }
}
