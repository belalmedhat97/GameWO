//
//  SearchGamesVCPresenter.swift
//  GameWO
//
//  Created by Belal medhat on 12/16/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
class SearchGamesPresenter:SearchGamesPresenterProtocols{
    weak var view: SearchGamesViewProtocols?
    private var gameList:[Results] = []
    init(view:SearchGamesViewProtocols){
        self.view = view
    }
    func handleDidSearch(searchValue:String) {
        self.view?.showLoading()
        NetworkCaller.Request(GamesRouter.searchGames(Value: searchValue)) { (Result:Result<GameListResposne, Error>) in
            switch Result {
            case .success(let response):
            print(response)
            if response.results?.count == 0 {
                self.view?.showError(show:true)
            }else{
                self.view?.showError(show:false)

            }
            self.gameList = response.results ?? []

            self.view?.hideLoading()
            self.view?.reloadGamesCollection()
            case .failure(let error):
            self.view?.hideLoading()
            self.view?.showAlert(title: "", message: error.localizedDescription)
            print(error)
            }
            
        }
    }
    
    func gameSearchList() -> [Results]{
        return gameList
    }
}
