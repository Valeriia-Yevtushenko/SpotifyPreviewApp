//
//  PlaylistTableViewHeaderFooterView.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 30.03.2022.
//

import UIKit

class PlaylistTableViewHeaderFooterView: UITableViewHeaderFooterView {
    var play: (() -> Void)!
    var shuffle: (() -> Void)!
    
    @IBAction private func shuffleButtonDidTap() {
        shuffle()
    }
    
    @IBAction private func playButtonDidTap() {
        play()
    }
}
