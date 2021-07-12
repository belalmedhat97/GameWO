//
//  GamesGenresPresenter.swift
//  GameWO
//
//  Created by Belal medhat on 9/4/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
class GamesGenresPresenter:GamesGenresPresenterProtocols{
  weak var view:GamesGenresViewProtocols?
  private var Genre:[GenreResult] = []
    init(view:GamesGenresViewProtocols) {
        self.view = view
    }
    func handleViewDidLoad() {
        self.view?.showLoading()
        Network.Request(URL:GamesRouter.gamesGenres.urlRequest) { (result:CustomResults<GameGenresResponse,GameErrorResponse, Error>) in
            switch result {
            case .success(let response):
            print(response)
            self.Genre = response.results ?? []
                    self.view?.hideLoading()
                    self.view?.reloadGenreCollection()
                
        
                
            case .failure(let FailResponse):
                    self.view?.hideLoading()
                    self.view?.showAlert(title: "", message: FailResponse.error ?? "")
                
         
                print(FailResponse.error ?? "")
            case .failureError(let error):
                print(error)
            }
            
        }
    }
    
    func GenreList() -> [GenreResult] {
        self.Genre
    }
    
    
}
