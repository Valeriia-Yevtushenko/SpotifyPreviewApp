//
//  ArtistTableViewDataSource.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 02.06.2021.
//

import UIKit

protocol ArtistTableViewDataSourceDelegate: AnyObject {
    func didSelectAlbum(at index: Int)
    func didSelectTrack(at index: Int)
    func scrollViewDidScroll()
}

final class ArtistTableViewDataSource: NSObject {
    private var sections: [Section] = []
    weak var delegate: ArtistTableViewDataSourceDelegate?
}

private extension ArtistTableViewDataSource {
    enum Section {
        case topTrack([TrackTableViewCellModel])
        case albums([TableViewCellModel])
        
        var count: Int {
            switch self {
            case .topTrack(_):
                return 5
            case .albums(let cells):
                return cells.count
            }
        }
        
        var name: String {
            switch self {
            case .topTrack(_):
                return "Top Tracks"
            case .albums(_):
                return "Top Albums"
            }
        }
    }
}

extension ArtistTableViewDataSource {
    func setupData(tracks: [TrackTableViewCellModel], albums: [TableViewCellModel]) {
        sections.append(.topTrack(tracks))
        sections.append(.albums(albums))
    }
}

extension ArtistTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll()
    }
}

extension ArtistTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.size.width, height: 50))
        headerLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        headerLabel.textAlignment = .left
        headerLabel.numberOfLines = 0
        headerLabel.adjustsFontSizeToFitWidth = true
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        return headerLabel
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .albums(let albums):
            let cell: TableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(albums[indexPath.row])
            return cell
        case .topTrack(let tracks):
            let cell: TrackTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(tracks[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            delegate?.didSelectTrack(at: indexPath.row)
        } else {
            delegate?.didSelectAlbum(at: indexPath.row)
        }
    }
}
