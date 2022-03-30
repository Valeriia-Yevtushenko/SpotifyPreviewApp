//
//  AlbumTableViewDataSource.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import UIKit

protocol AlbumTableViewDataSourceDelegate: AnyObject {
    func didSelectItem(at index: Int)
    func playDidTap()
    func shuffleDidTap()
}

final class AlbumTableViewDataSource: NSObject {
    private var viewModels: [TrackTableViewCellModel] = []
    private var headerModel: AlbumTableViewHeaderFooterViewModel?
    weak var delegate: AlbumTableViewDataSourceDelegate?
}

extension AlbumTableViewDataSource {
    func setupData(tracks: [TrackTableViewCellModel], album: AlbumTableViewHeaderFooterViewModel) {
        viewModels = tracks
        headerModel = album
    }
}

extension AlbumTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: AlbumTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView()
        header.configure(headerModel)
        header.shuffle = delegate?.shuffleDidTap
        header.play = delegate?.playDidTap
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }
}

extension AlbumTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(viewModels[indexPath.row])
        return cell
    }
}
