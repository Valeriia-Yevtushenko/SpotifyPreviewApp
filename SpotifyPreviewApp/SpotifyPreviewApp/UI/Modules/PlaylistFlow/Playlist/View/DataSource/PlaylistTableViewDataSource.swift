//
//  PlaylistTableViewDataSource.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 30.03.2022.
//

import UIKit

protocol PlaylistTableViewDataSourceDelegate: AnyObject {
    func didTapPlay()
    func didTapShuffle()
    func didTapShareItem(at index: Int)
    func didTapAddItemToPlaylist(at index: Int)
    func didTapDownloadItem(at index: Int)
    func didSelectItem(at index: Int)
    func didTapShowItemArtist(at index: Int)
    func didTapShowItemAlbum(at index: Int)
    func didTapDeleteItem(at index: Int)
    func scrollViewDidScroll()
}

final class PlaylistTableViewDataSource: NSObject {
    private var tracks: [TrackTableViewCellModel] = []
    private var type: PlaylistType?
    weak var delegate: PlaylistTableViewDataSourceDelegate?
}

extension PlaylistTableViewDataSource {
    func setupViewModel(_ tracks: [TrackTableViewCellModel], type: PlaylistType) {
        self.tracks = tracks
        self.type = type
    }
}

extension PlaylistTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !tracks.isEmpty else {
            return nil
        }
        
        let header: PlaylistTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView()
        header.shuffle = delegate?.didTapShuffle
        header.play = delegate?.didTapPlay
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
            
            guard self.type == .user else {
                return UIMenu.init(children: [share,
                                              download,
                                              addToPlaylist,
                                              showAlbum,
                                              showArtist])
            }
            
            let deleteItem = UIAction(title: TrackContextMenuAction.delete.rawValue,
                                     image: TrackContextMenuAction.delete.image) { _ in
                 self.delegate?.didTapDeleteItem(at: indexPath.row)
            }
            
            return UIMenu.init(children: [addToPlaylist,
                                          deleteItem,
                                          share,
                                          download,
                                          showArtist,
                                          showAlbum])
        }
        
        return configuration
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
