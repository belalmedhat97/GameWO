//
//  GamesStorePresenter.swift
//  GameWO
//
//  Created by Belal medhat on 9/24/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
class GameStorePresenter:GamesStorePresenterProtocol{
    
  weak var view: GamesStoreViewProtocol?
  private var Stores:[StoreResults] = []
    init(view:GamesStoreViewProtocol) {
        self.view = view
    }
    func handleViewDidLoad() {
        self.view?.showLoading()
        NetworkCaller.Request(StoreRouter.storeList) { (result:Result<GamesStoreResponse, Error>) in
            switch result {
            case .success(let response):
            print(response)
            self.Stores = response.results ?? []
            self.view?.hideLoading()
            self.view?.reloadStoreCollection()
            case .failure(let error):
            self.view?.hideLoading()
            self.view?.showAlert(title: "", message: error.localizedDescription)
            print(error)
            }
            
        }
    }
    
    func StoreList() -> [StoreResults] {
        self.Stores
    }
    
    
}
