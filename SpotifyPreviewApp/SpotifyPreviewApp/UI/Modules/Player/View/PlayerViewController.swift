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
    @IBOutlet private weak var currentTimeLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var infoStackView: UIStackView!
    @IBOutlet private weak var containerStackView: UIStackView!
    @IBOutlet private weak var playerProgressSlider: UISlider!
    private let tableView = UITableView()
    private var timer: Timer?
    private var isPlaying = true
    private var isRepeating = false
    private var isListOfTracksShowing = false
    var dataSource: TrackTableViewDataSource?
    var output: PlayerViewOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
        if isListOfTracksShowing {
            removeListOfTrack()
        } else {
            showListOfTracks()
        }
        
        isListOfTracksShowing = !isListOfTracksShowing
    }
}

private extension PlayerViewController {
    func setupUI() {
        tableView.backgroundColor = .secondarySystemBackground
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: TrackTableViewCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier )
        
        let image = UIImage(systemName: "circle.fill")
        playerProgressSlider.setThumbImage(image, for: .normal)
        
        let size = view.frame.width / 1.6
        imageWidhtLayoutConstraint.constant = size
        imageHeightLayoutConstraint.constant = size
    }
    
    func removeListOfTrack() {
        containerStackView.removeArrangedSubview(tableView)
        infoStackView.axis = .vertical
        let size = view.frame.width / 1.6
        imageWidhtLayoutConstraint.constant = size
        imageHeightLayoutConstraint.constant = size
    }
    
    func showListOfTracks() {
        output?.viewDidTapShowListOfTracks()
        let size = view.frame.width / 5.6
        imageWidhtLayoutConstraint.constant = size
        imageHeightLayoutConstraint.constant = size
        infoStackView.axis = .horizontal
        containerStackView.insertArrangedSubview(tableView, at: 1)
    }
}

@objc private extension PlayerViewController {
    func updateSliderValue(_ timer: Timer) {
        guard isPlaying else {
            return
        }
        
        output?.viewNeedToRefreshPlayerTime()
    }
}

extension PlayerViewController: PlayerViewInputProtocol {
    func setupListOfTracks(_ tracks: [TrackTableViewCellModel]) {
        dataSource?.setupViewModel(tracks)
        tableView.reloadData()
    }
    
    func refreshPlayerTime(_ time: Double) {
        currentTimeLabel.text = time.asString(style: .abbreviated)
        playerProgressSlider.value = Float(time)
    }
    
    func setupPlayer(with item: PlayerItem) {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSliderValue(_:)), userInfo: nil, repeats: true)
        timer?.fire()
        songNameLabel.text = item.title
        artistsLabel.text = item.artists
        playerProgressSlider.maximumValue = 0
        playerProgressSlider.maximumValue = Float(item.duration ?? 0)
        durationLabel.text = item.duration?.asString(style: .abbreviated)
        
        if let imageUrl = item.image {
            imageView.setImage(withUrl: imageUrl)
        }
    }
}
