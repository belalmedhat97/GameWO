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
        NetworkCaller.Request(GamesRouter.gamesGenres) { (result:Result<GameGenresResponse, Error>) in
            switch result {
            case .success(let response):
            print(response)
            self.Genre = response.results ?? []
            self.view?.hideLoading()
            self.view?.reloadGenreCollection()
            case .failure(let error):
            self.view?.hideLoading()
            self.view?.showAlert(title: "", message: error.localizedDescription)
            print(error)
            }
            
        }
    }
    
    func GenreList() -> [GenreResult] {
        self.Genre
    }
    
    
}
