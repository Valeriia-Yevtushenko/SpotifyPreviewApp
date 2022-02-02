//
//  SearchInteractor.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import Foundation
import PromiseKit

final class SearchViewInteractor: SearchInteractorInputProtocol {
    var presenter: SearchInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol!
    
    func fetchSearchData(_ text: String) {
        guard let track = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let promise: Promise<ListOfTrack> = networkService.fetch(Request.search.createUrl(data: track))
        
        firstly {
            promise
        }.done { data in
            self.presenter?.interactorDidFetchData(data)
        }.catch { _ in
            self.presenter?.interactorFailedToFetchData()
        }
    }
}
