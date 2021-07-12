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
        Network.Request(URL:GamesRouter.searchGames(Value: searchValue).urlRequest) { (Result:CustomResults<GameListResposne,GameErrorResponse ,Error>) in
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
                        
            case .failure(let FailResponse):
                    self.view?.hideLoading()
                    self.view?.showAlert(title: "", message: FailResponse.error ?? "")
                
           
            print(FailResponse)
                
            case .failureError(let error):
                print(error)
            }
            
        }
    }
    
    func gameSearchList() -> [Results]{
        return gameList
    }
}
