//
//  EditPlaylistViewController.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 06.02.2022.
//

import UIKit
import PromiseKit

struct EditPlaylistViewControllerModel {
    var name: String
    var description: String
    var imageUrl: String?
    var isPublic: Bool
}

class EditPlaylistViewController: UIViewController {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var visibleStatusStackView: UIStackView!
    @IBOutlet private weak var visibleStatusSwitch: UISwitch!
    @IBOutlet private weak var descriptionTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    private var newImageData: Data?
    private var model: EditPlaylistViewControllerModel!
    
    private var isModified: Bool = false {
        didSet {
            saveButton.isEnabled = isModified
        }
    }
    
    private var isImageSizeAvaible: Bool {
        guard let imageDataCount = newImageData?.count else {
            return true
        }
        
        let byteCountFormatter = ByteCountFormatter()
        byteCountFormatter.allowedUnits = [.useKB]
        
        guard let mbCount = Double(byteCountFormatter.string(fromByteCount: Int64(imageDataCount)).replacingOccurrences(of: " KB", with: "")),
           mbCount < 256 else {
            return false
        }
        
        return true
    }
    
    var output: EditPlaylistViewOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        output?.viewDidLoad()
    }
}

private extension EditPlaylistViewController {
    @IBAction func saveButtonDidTap() {
        guard isImageSizeAvaible else {
            displayErrorAlert(with: "Image size is too big, please choose another one.")
            return
        }
        
        output?.viewDidTapSavePlaylist(with: NewPlaylist(name: model.name,
                                                         description: model.description,
                                                         isPublic: visibleStatusSwitch.isOn),
                                       image: newImageData)
    }
    
    @IBAction func cancelButtonDidTap() {
        guard (isModified || newImageData != nil) else {
            output?.viewDidTapCancel()
            return
        }
        
        displayConfirmationAlert()
    }
    
    @IBAction func visibleStatusDidChange() {
        isModified = true
    }
    
    @IBAction func changeImageButtonDidTap() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    func configure() {
        nameTextField.delegate = self
        descriptionTextField.delegate = self
        visibleStatusStackView.layer.cornerRadius = 6
        saveButton.isEnabled = false
    }
    
    func displayConfirmationAlert() {
        let alert = UIAlertController(title: "Are you sure?",
                                      message: "Your changes will not be saved.",
                                      preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let discardButton = UIAlertAction(title: "Discard", style: .destructive, handler: { _ in
            self.output?.viewDidTapCancel()
        })
        
        alert.addAction(cancelButton)
        alert.addAction(discardButton)
        present(alert, animated: true, completion: nil)
    }
}

extension EditPlaylistViewController: EditPlaylistViewInputProtocol {
    func setupPlaylistInfo(_ model: EditPlaylistViewControllerModel) {
        self.model = model
        nameTextField.text = model.name
        descriptionTextField.text = model.description
        visibleStatusSwitch.isOn = model.isPublic
        guard let url = model.imageUrl else {
            imageView.image = UIImage(systemName: "music.note.list")?.withRenderingMode(.alwaysOriginal)
            imageView.backgroundColor = .placeholderText
            return
        }
        
        imageView.setImage(withUrl: url)
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

extension EditPlaylistViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newValue: String = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        isModified = true
        
        switch textField {
        case nameTextField:
            model?.name = newValue
        case descriptionTextField:
            model?.description = newValue
        default:
            break
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return true
    }
}

extension EditPlaylistViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        imageView.image = image
        saveButton.isEnabled = true
        self.newImageData = image?.jpegData(compressionQuality: 0.5)?.base64EncodedData()
        dismiss(animated: true)
    }
}
