//
//  PlayerViewController.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 06.03.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    @IBOutlet private weak var accessoryView: UIView!
    @IBOutlet private weak var imageView: CustomImageView!
    @IBOutlet private weak var imageViewContainerView: UIView!
    @IBOutlet private weak var imageWidhtLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var artistsLabel: UILabel!
    @IBOutlet private weak var currentTimeLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var togglePlayPauseButton: UIButton!
    @IBOutlet private weak var infoStackView: UIStackView!
    @IBOutlet private weak var containerStackView: UIStackView!
    @IBOutlet private weak var playerProgressSlider: UISlider!
    private let tableView = UITableView()
    private var imageViewContainerWidthViewConstraint: NSLayoutConstraint?
    private var timer: Timer?
    private var isPlaying = true
    private var isRepeating = false
    private var isListOfTracksShowing = false
    var dataSource: PlayerTableViewDataSource?
    var output: PlayerViewOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        output?.viewDidLoad()
    }
}

private extension PlayerViewController {
    @IBAction func handlePanGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        output?.viewDidTapDismiss(with: true)
    }
    
    @IBAction func playerProgressSliderDidChange(_ sender: UISlider) {
        output?.viewDidChangePlayerTime(Double(sender.value))
    }
    
    @IBAction func nextButtonDidTap() {
        output?.viewDidTapNext()
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
        accessoryView.layer.cornerRadius = .pi
    
        dataSource?.delegate = self
        tableView.backgroundColor = .secondarySystemBackground
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: TrackTableViewCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier )
        
        let image = UIImage(systemName: "circle.fill")
        playerProgressSlider.setThumbImage(image, for: .normal)
        
        let size = view.frame.width / 1.3
        imageWidhtLayoutConstraint.constant = size
        imageHeightLayoutConstraint.constant = size
    }
    
    func removeListOfTrack() {
        containerStackView.removeArrangedSubview(tableView)
        imageViewContainerWidthViewConstraint?.isActive = false
        infoStackView.alignment = .fill
        infoStackView.axis = .vertical
        let size = view.frame.width / 1.3
        imageWidhtLayoutConstraint.constant = size
        imageHeightLayoutConstraint.constant = size
    }
    
    func showListOfTracks() {
        let size = view.frame.width / 5.6
        output?.viewDidTapShowListOfTracks()
        imageWidhtLayoutConstraint.constant = size
        imageHeightLayoutConstraint.constant = size
        imageViewContainerWidthViewConstraint = imageViewContainerView.widthAnchor.constraint(equalToConstant: size)
        imageViewContainerWidthViewConstraint?.isActive = true
        infoStackView.axis = .horizontal
        infoStackView.alignment = .center
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
    func setupPlayer(with item: PlayerItem, isPlaying: Bool) {
        if isPlaying {
            togglePlayPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            togglePlayPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        
        self.isPlaying = isPlaying
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSliderValue(_:)), userInfo: nil, repeats: true)
        timer?.fire()
        songNameLabel.text = item.title
        artistsLabel.text = item.artists
        playerProgressSlider.maximumValue = 0
        playerProgressSlider.maximumValue = Float(item.duration ?? 0)
        durationLabel.text = item.duration?.asString(style: .abbreviated)
        
        if let imageUrl = item.image {
            imageView.loadImageUsingUrlString(urlString: imageUrl)
        }
    }
    
    func stopPlayer() {
        togglePlayPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
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
            imageView.loadImageUsingUrlString(urlString: imageUrl)
        }
    }
    
    func displayErrorAlert() {
        let alert = UIAlertController(title: "Error",
                                      message: "We can't play this track. It is only for premium version.",
                                      preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .destructive, handler: { _ in
            self.output?.viewDidTapDismiss(with: false)
        })
        
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

extension PlayerViewController: PlayerTableViewDataSourceDelegate {
    func didSelectItem(at index: Int) {
        output?.viewDidChangePlayerItem(index)
    }
}
