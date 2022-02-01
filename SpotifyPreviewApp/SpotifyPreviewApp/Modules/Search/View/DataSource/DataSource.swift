//
//  DataSource.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import UIKit

final class TableViewDataSource: NSObject {
    private var tracks: [TrackTableViewCellModel] = []
}

extension TableViewDataSource {
    func setupViewModel(_ tracks: [TrackTableViewCellModel]) {
        self.tracks = tracks
    }
}
extension TableViewDataSource: UITableViewDelegate {}

extension TableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(tracks[indexPath.row])
        return cell
    }
}
