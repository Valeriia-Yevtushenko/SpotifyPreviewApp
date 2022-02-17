//
//  AlbumTableViewDataSource.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import UIKit

protocol AlbumTableViewDataSourceDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

final class AlbumTableViewDataSource: NSObject {
    private var sections: [Section] = []
    weak var delegate: AlbumTableViewDataSourceDelegate?
}

private extension AlbumTableViewDataSource {
    enum Section {
        case track([TrackTableViewCellModel])
        case albumInfo(AlbumTableViewCellModel)
        
        var count: Int {
            switch self {
            case .track(let cells):
                return cells.count
            case .albumInfo(_):
                return 1
            }
        }
    }
}

extension AlbumTableViewDataSource {
    func setupData(tracks: [TrackTableViewCellModel], album: AlbumTableViewCellModel) {
        sections.append(.albumInfo(album))
        sections.append(.track(tracks))
    }
}

extension AlbumTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }
}

extension AlbumTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .albumInfo(let album):
            let cell: AlbumTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(album)
            return cell
        case .track(let tracks):
            let cell: TrackTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(tracks[indexPath.row])
            return cell
        }
    }
}
