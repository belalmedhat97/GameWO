//
//  DetailsVCPresenter.swift
//  GameWO
//
//  Created by Belal medhat on 9/27/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
class DetailsVCPresenter:DetailsVCPresenterProtocols{
 
    

    weak var view: DetailsVCViewProtocols?
    private var Screens: [ScreenShotsResults] = []
    private var details:GameDetailsResponse? = nil
    private var PlatformsData:[PlatformGameDetails] = []
    private var trailer:[TrailerResults] = []
    private var storeDetails:[GameStores] = []
    private var ClipData:[Clip] = []

    init(view:DetailsVCViewProtocols){
        self.view = view
    }
    func ViewDidLoadDetails(id:String) {
            self.view?.showLoading()
        NetworkCaller.Request(GamesRouter.gamesDetails(id: id)) { (result:Result<GameDetailsResponse, Error>) in
                switch result {
                case .success(let response):
                print(response)
                self.details = response
                self.view?.hideLoading()
                if let gameDetails = self.details {
                    self.view?.reloadVCDetails(Details: gameDetails)
                    self.PlatformsData = gameDetails.platforms ?? []
                    self.storeDetails = gameDetails.stores ?? []
                    
                    self.view?.reloadPlatforms()
                    self.view?.reloadStores()
                }
                case .failure(let error):
                self.view?.hideLoading()
                self.view?.showAlert(title: "", message: error.localizedDescription)
                print(error)
                }
                
            }
    }
    
    func ViewDidLoadScreenshots(id:String) {
        self.view?.showLoading()
        NetworkCaller.Request(GamesRouter.Screenshots(id: id)) { (result:Result<ScreenShots, Error>) in
                switch result {
                case .success(let response):
                print(response)
                self.Screens = response.results ?? []
                self.view?.hideLoading()
                self.view?.reloadScreenshots()
                case .failure(let error):
                self.view?.hideLoading()
                self.view?.showAlert(title: "", message: error.localizedDescription)
                print(error)
                }
                
            }

    }
    func ViewDidLoadTrailer(id: String) {
             self.view?.showLoading()
           NetworkCaller.Request(GamesRouter.Trailer(id: id)) { (result:Result<TrailerResponse, Error>) in
                   switch result {
                   case .success(let response):
                   print(response)
                   if response.results?.count == 0 {
                    self.view?.removeTrailerCollection()
                   }else
                   {
                   self.trailer = response.results ?? []
                   self.view?.hideLoading()
                   self.view?.reloadTrailerVideos()
                    }
                   case .failure(let error):
                   self.view?.hideLoading()
                   self.view?.showAlert(title: "", message: error.localizedDescription)
                   print(error)
                   }
                   
               }
    }
    
    
    func ScreenshotsLists() -> [ScreenShotsResults] {
        self.Screens
    }
    func TrailerList() -> [TrailerResults] {
        self.trailer
    }
    func Platforms() -> [PlatformGameDetails] {
        self.PlatformsData
    }
    func Stores() -> [GameStores] {
        self.storeDetails
     }
}
