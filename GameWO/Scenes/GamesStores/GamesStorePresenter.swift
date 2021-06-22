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
        Network.Request(URL: StoreRouter.storeList.urlRequest) { (result:CustomResults<GamesStoreResponse,GameErrorResponse, Error>) in
            switch result {
            case .success(let response):
            print(response)
            self.Stores = response.results ?? []
            self.view?.hideLoading()
            self.view?.reloadStoreCollection()
            case .failure(let FailResponse):
            self.view?.hideLoading()
            self.view?.showAlert(title: "", message: FailResponse.error ?? "")
            print(FailResponse)
            case .failureError(let error):
                print(error)
            }
            
        }
    }
    
    func StoreList() -> [StoreResults] {
        self.Stores
    }
    
    
}
