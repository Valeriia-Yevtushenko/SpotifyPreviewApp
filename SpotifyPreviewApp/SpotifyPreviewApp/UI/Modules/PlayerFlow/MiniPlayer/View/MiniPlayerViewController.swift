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
    @IBOutlet private weak var imageView: UIImageView!
    private var isPlaying = true
    var output: MiniPlayerViewOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        output?.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    @IBAction func togglePlayPauseButtonDidTap(_ sender: UIButton) {
        if isPlaying {
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        
        isPlaying = !isPlaying
        output?.viewDidTapTogglePlayPause()
    }
    
    @IBAction func nextButtonDidTap() {
        output?.viewDidTapNext()
    }
}

extension MiniPlayerViewController: MiniPlayerViewInputProtocol {
    func setupPlayer(with item: PlayerItem) {
        songNameLabel.text = item.title
        artistsLabel.text = item.artists
        
        if let imageUrl = item.image {
            imageView.setImage(withUrl: imageUrl)
        }
    }
}
