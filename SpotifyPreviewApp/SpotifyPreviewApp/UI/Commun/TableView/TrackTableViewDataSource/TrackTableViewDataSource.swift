//
//  DataSource.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import UIKit

protocol TrackTableViewDataSourceDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

final class TrackTableViewDataSource: NSObject {
    private var tracks: [TrackTableViewCellModel] = []
    weak var delegate: TrackTableViewDataSourceDelegate?
}

extension TrackTableViewDataSource {
    func setupViewModel(_ tracks: [TrackTableViewCellModel]) {
        self.tracks = tracks
    }
}
extension TrackTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }
}

extension TrackTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(tracks[indexPath.row])
        return cell
    }
}
