//
//  SearchInteractor.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import Foundation
import PromiseKit

final class SearchInteractor: SearchInteractorInputProtocol {
    var networkService: NetworkServiceProtocol!
    var urlBuilder: URLBuilderProtocol!
    weak var presenter: SearchInteractorOutputProtocol?
    
    func fetchSearchText(_ text: String) {
        guard let track = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let promise: Promise<ListOfSearchedTracks> = networkService.fetch(urlBuilder
                                                                            .with(path: .search)
                                                                            .with(queryItems: ["q": track,
                                                                                               "type": "track",
                                                                                               "limit": "50"])
                                                                            .build())
        
        promise.done { data in
            self.presenter?.interactorDidFetchData(data)
        }.catch { _ in
            self.presenter?.interactorFailedToFetchData()
        }
    }
}
