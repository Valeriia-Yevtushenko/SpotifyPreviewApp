//
//  ProfileDataSource.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 01.06.2021.
//

import UIKit

protocol TableViewDataSourceDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

final class TableViewDataSource: NSObject {
    private var viewModel: [TableViewCellModel] = []
    weak var delegate: TableViewDataSourceDelegate?
}

extension TableViewDataSource {
    func setupViewModel(_ viewModel: [TableViewCellModel]) {
        self.viewModel = viewModel
    }
}

extension TableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }
}

extension TableViewDataSource: UITableViewDataSource {
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
