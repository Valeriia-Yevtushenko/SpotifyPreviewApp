//
//  MiniPlayerViewController.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 29.03.2022.
//

import UIKit

class MiniPlayerViewController: UIViewController {
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var artistsLabel: UILabel!
    @IBOutlet private weak var togglePlayPauseButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    private let tapGestureRecognizer = UITapGestureRecognizer()
    private var isPlaying = true
    var output: MiniPlayerViewOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGesture()
        output?.viewDidLoad()
    }
    
    @IBAction func togglePlayPauseButtonDidTap() {
        if isPlaying {
            togglePlayPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            togglePlayPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        
        isPlaying = !isPlaying
        output?.viewDidTapTogglePlayPause()
    }
    
    @IBAction func nextButtonDidTap() {
        output?.viewDidTapNext()
    }
}

extension MiniPlayerViewController: MiniPlayerViewInputProtocol {
    func stopPlayer() {
        togglePlayPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    func updatePlayer(with item: PlayerItem, isPlaying: Bool) {
        
        songNameLabel.text = item.title
        artistsLabel.text = item.artists
        
        if let imageUrl = item.image {
            imageView.setImage(withUrl: imageUrl)
        }
        
        if isPlaying {
            togglePlayPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            togglePlayPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        
        self.isPlaying = isPlaying
    }
    
    func setupPlayer(with item: PlayerItem) {
        songNameLabel.text = item.title
        artistsLabel.text = item.artists
        
        if let imageUrl = item.image {
            imageView.setImage(withUrl: imageUrl)
        }
    }
    
    func displayErrorAlert() {
        let alert = UIAlertController(title: "Error",
                                      message: "We can't play this track. It is only for premium version.",
                                      preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
        
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

private extension MiniPlayerViewController {
    func setupGesture() {
        view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(handleTapGestureRecognizer(_:)))
    }
}

@objc private extension MiniPlayerViewController {
    func handleTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        output?.viewDidTapOpenPlayer()
    }
}
