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
    @IBOutlet private weak var playerProgressSlider: UISlider!
    private var timer: Timer?
    private var isPlaying = true
    private var isRepeating = false
    var output: PlayerViewOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewDidLoad()
    }
}

private extension PlayerViewController {
    @IBAction func playerProgressSliderDidChange(_ sender: UISlider) {
        output?.viewDidChangePlayerTime(Double(sender.value))
    }
    
    @IBAction func nextButtonDidTap() {
        output?.viewDidTapNext()
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
    
    @IBAction func toggleRepeatButtonDidTap(_ sender: UIButton) {
        if isRepeating {
            sender.setImage(UIImage(systemName: "repeat"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "repeat.1"), for: .normal)
        }
        
        isRepeating = !isRepeating
        output?.viewDidTapToggleRepeat()
    }
    
    @IBAction func previousButtonDidTap() {
        output?.viewDidTapPrevious()
    }
    
    @IBAction func shuffleButtonDidTap() {
        output?.viewDidTapShuffle()
    }
       
    @IBAction func showListOfTracksButtonDidTap() {
        
    }
}

@objc extension PlayerViewController {
    func updateSliderValue(_ timer: Timer) {
        guard isPlaying else {
            return
        }
        
        output?.viewNeedToRefreshPlayerTime()
    }
}

extension PlayerViewController: PlayerViewInputProtocol {
    func refreshPlayerTime(_ time: Double) {
        playerProgressSlider.value = Float(time)
    }
    
    func setupPlayer(with item: PlayerItem) {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSliderValue(_:)), userInfo: nil, repeats: true)
        timer?.fire()
        songNameLabel.text = item.title
        artistsLabel.text = item.artists
        playerProgressSlider.maximumValue = 0
        playerProgressSlider.maximumValue = Float(item.duration ?? 0)
        
        if let imageUrl = item.image {
            imageView.setImage(withUrl: imageUrl)
        }
    }
}
