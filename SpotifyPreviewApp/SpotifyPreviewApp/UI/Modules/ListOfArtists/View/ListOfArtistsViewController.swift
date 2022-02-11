//
//  ListOfArtistsViewController.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import UIKit

class ListOfArtistsViewController: UIViewController {
    var output: ListOfArtistsViewOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewDidLoad()
    }
}

extension ListOfArtistsViewController: ListOfArtistsViewInputProtocol {
    func setupData(_ model: [TableViewCellModel]) {
        
    }
    
    func reloadData() {
        
    }
    
    func displayLabel(with text: String) {
        
    }
}
