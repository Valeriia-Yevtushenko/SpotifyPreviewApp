//
//  AlbumTableViewDataSource.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import UIKit

protocol AlbumTableViewDataSourceDelegate: AnyObject {
    func didTapShareItem(at index: Int)
    func didTapAddItemToPlaylist(at index: Int)
    func didTapDownloadItem(at index: Int)
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
        guard !viewModels.isEmpty else {
            return nil
        }
        
        let header: AlbumTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView()
        header.configure(headerModel)
        header.shuffle = delegate?.shuffleDidTap
        header.play = delegate?.playDidTap
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard indexPath.section == 0 else {
            return nil
        }
        
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            let share = UIAction(title: TrackContextMenuAction.share.rawValue,
                                 image: TrackContextMenuAction.share.image) { _ in
                self.delegate?.didTapShareItem(at: indexPath.row)
            }
            
            let addToPlaylist = UIAction(title: TrackContextMenuAction.addToPlaylist.rawValue,
                                         image: TrackContextMenuAction.addToPlaylist.image) { _ in
                self.delegate?.didTapAddItemToPlaylist(at: indexPath.row)
            }
            
            let download = UIAction(title: TrackContextMenuAction.download.rawValue,
                                    image: TrackContextMenuAction.download.image) { _ in
                self.delegate?.didTapDownloadItem(at: indexPath.row)
            }
            
            return UIMenu.init(children: [share,
                                          download,
                                          addToPlaylist])
        }
        
        return configuration
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
