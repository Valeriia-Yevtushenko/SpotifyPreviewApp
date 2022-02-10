//
//  DataSource.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import UIKit

protocol TrackTableViewDataSourceDelegate: AnyObject {
    func scrollViewDidScroll()
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll()
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
