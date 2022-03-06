//
//  PlayerViewController.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 06.03.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageWidhtLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var artistsLabel: UILabel!
    @IBOutlet private weak var infoStackView: UIStackView!
    @IBOutlet private weak var containerStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

private extension PlayerViewController {
    @IBAction func nextButtonDidTap() {
        
    }
    
    @IBAction func playPauseButtonDidTap(_ sender: UIButton) {
    }
    
    @IBAction func previousButtonDidTap() {
        
    }
    
    @IBAction func shuffleButtonDidTap() {
        
    }
    
    @IBAction func repeatButtonDidTap() {
        
    }
    
    @IBAction func showListOfTracksButtonDidTap() {
        
    }
}
