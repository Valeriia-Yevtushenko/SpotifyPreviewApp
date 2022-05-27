//
//  SearchTableViewDataSource.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 03.04.2022.
//

import UIKit

protocol SearchTableViewDataSourceDelegate: AnyObject {
    func didSelectItem(at index: Int)
    func didTapShareItem(at index: Int)
    func didTapAddItemToPlaylist(at index: Int)
    func didTapDownloadItem(at index: Int)
    func didTapShowItemArtist(at index: Int)
    func didTapShowItemAlbum(at index: Int)
}

final class SearchTableViewDataSource: NSObject {
    private var tracks: [TrackTableViewCellModel] = []
    weak var delegate: SearchTableViewDataSourceDelegate?
}

extension SearchTableViewDataSource {
    func setupViewModel(_ tracks: [TrackTableViewCellModel]) {
        self.tracks = tracks
    }
}
extension SearchTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
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
            
            let showAlbum = UIAction(title: TrackContextMenuAction.album.rawValue,
                                     image: TrackContextMenuAction.album.image) { _ in
                 self.delegate?.didTapShowItemAlbum(at: indexPath.row)
            }
            
            let showArtist = UIAction(title: TrackContextMenuAction.artist.rawValue,
                                     image: TrackContextMenuAction.artist.image) { _ in
                 self.delegate?.didTapShowItemArtist(at: indexPath.row)
            }
            
            return UIMenu.init(children: [addToPlaylist,
                                          share,
                                          download,
                                          showArtist,
                                          showAlbum])
        }
        
        return configuration
    }
}

extension SearchTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(tracks[indexPath.row])
        return cell
    }
}
