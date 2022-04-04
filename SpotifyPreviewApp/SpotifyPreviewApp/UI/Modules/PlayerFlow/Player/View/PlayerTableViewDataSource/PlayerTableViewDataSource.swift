//
//  ProfileDataSource.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 01.06.2021.
//

import UIKit

protocol PlayerTableViewDataSourceDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

final class PlayerTableViewDataSource: NSObject {
    private var viewModel: [TableViewCellModel] = []
    weak var delegate: PlayerTableViewDataSourceDelegate?
}

extension PlayerTableViewDataSource {
    func setupViewModel(_ viewModel: [TableViewCellModel]) {
        self.viewModel = viewModel
    }
}

extension PlayerTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }
}

extension PlayerTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.configure(viewModel[indexPath.row])
        return cell
    }
}
