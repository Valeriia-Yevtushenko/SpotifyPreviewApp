//
//  ListOfArtistTableViewDataSource.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 05.04.2022.
//

import UIKit

protocol ArtistsTableViewDataSourceDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

final class ArtistsTableViewDataSource: NSObject {
    private var tracks: [TableViewCellModel] = []
    weak var delegate: ArtistsTableViewDataSourceDelegate?
}

extension ArtistsTableViewDataSource {
    func setupViewModel(_ tracks: [TableViewCellModel]) {
        self.tracks = tracks
    }
}

extension ArtistsTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }
}

extension ArtistsTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(tracks[indexPath.row])
        return cell
    }
}
