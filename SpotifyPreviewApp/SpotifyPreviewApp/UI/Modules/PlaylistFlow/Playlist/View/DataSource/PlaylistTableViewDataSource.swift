//
//  PlaylistTableViewDataSource.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 30.03.2022.
//

import UIKit

protocol PlaylistTableViewDataSourceDelegate: AnyObject {
    func playDidTap()
    func shuffleDidTap()
    func didSelectItem(at index: Int)
    func scrollViewDidScroll()
}

final class PlaylistTableViewDataSource: NSObject {
    private var tracks: [TrackTableViewCellModel] = []
    weak var delegate: PlaylistTableViewDataSourceDelegate?
}

extension PlaylistTableViewDataSource {
    func setupViewModel(_ tracks: [TrackTableViewCellModel]) {
        self.tracks = tracks
    }
}
extension PlaylistTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: PlaylistTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView()
        header.shuffle = delegate?.shuffleDidTap
        header.play = delegate?.playDidTap
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }
}

extension PlaylistTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(tracks[indexPath.row])
        return cell
    }
}
