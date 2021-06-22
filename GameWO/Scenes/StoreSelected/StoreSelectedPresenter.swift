//
//  GenreSelectedPresenter.swift
//  GameWO
//
//  Created by Belal medhat on 12/21/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
class StoreSelectedPresenter:StoreSelectedPresenterProtocols{

  weak var view: StoreSelectedViewProtocols?
    private var StoreList:[Results] = []

    init(view:StoreSelectedViewProtocols) {
        self.view = view
    }
    func handleViewDidLoadStore(StoreID:String,showloader:Bool,pageSize:String,Page:String,ordering:String,completionHandler: @escaping ()->()?) {
        if showloader == true {
        self.view?.showLoading()
        }
        NetworkCaller.Request(GamesRouter.storesGames(storeId: StoreID, page: Page, page_size: pageSize, ordering: ordering)) { (result:Result<GameListResposne,Error>) in
            switch result{
             case .success(let response):
                 print(response)
                 if response.next != nil { self.view?.NextPage = true } else {self.view?.NextPage = false}
                 if response.previous != nil { self.view?.PreviousPage = true
                    self.view?.ChangeScrollCollectionBottom()
                 } else {self.view?.PreviousPage = false
                    self.view?.ChangeScrollCollectionBottom()
                 }
                 self.StoreList = response.results ?? []
                 if showloader == true {
                    self.view?.hideLoading()
                 }
                 self.view?.reloadStoreCollection()
                completionHandler()
             case .failure(let error):
                self.view?.showAlert(title: "", message: error.localizedDescription)
                 print(error)
                completionHandler()
             }
        }
    }
    func gameStoreList() -> [Results] {
        return self.StoreList
    }
    
    
}
