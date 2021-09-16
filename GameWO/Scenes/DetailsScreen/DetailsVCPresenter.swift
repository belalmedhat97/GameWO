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
        Network.Request(URL:GamesRouter.gamesDetails(id: id).urlRequest) { (result:CustomResults<GameDetailsResponse,GameErrorResponse, Error>) in
                switch result {
                case .success(let response):
//                print(response)
                self.details = response
                        self.view?.hideLoading()
                        if let gameDetails = self.details {
                            self.view?.reloadVCDetails(Details: gameDetails)
                            self.PlatformsData = gameDetails.platforms ?? []
                            self.storeDetails = gameDetails.stores ?? []
                            
                            self.view?.reloadPlatforms()
                            self.view?.reloadStores()
                        }
//
           
                case .failure(let FailResponse):
                        self.view?.hideLoading()
                        self.view?.showAlert(title: "", message: FailResponse.error ?? "")
//                        print(FailResponse)
//
                case .failureError(let error):
                    print(error)
                }
                
            }
    }
    
    func ViewDidLoadScreenshots(id:String) {
        self.view?.showLoading()
        Network.Request(URL:GamesRouter.Screenshots(id: id).urlRequest) { (result:CustomResults<ScreenShots,GameErrorResponse, Error>) in
                switch result {
                case .success(let response):
//                print(response)
                self.Screens = response.results ?? []
                        self.view?.hideLoading()
                        self.view?.reloadScreenshots()
//
           
                case .failure(let FailResponse):
                        self.view?.hideLoading()
                        self.view?.showAlert(title: "", message: FailResponse.error ?? "")

//
//                print(FailResponse)
                case .failureError(let error):
                    print(error)
                }
                
            }

    }
    func ViewDidLoadTrailer(id: String) {
             self.view?.showLoading()
        Network.Request(URL:GamesRouter.Trailer(id: id).urlRequest) { (result:CustomResults<TrailerResponse,GameErrorResponse ,Error>) in
                   switch result {
                   case .success(let response):
//                   print(response)
                        if response.results?.count == 0 {
                         self.view?.removeTrailerCollection()
                        }else
                        {
                        self.trailer = response.results ?? []
                        self.view?.hideLoading()
                        self.view?.reloadTrailerVideos()
                         }
                    
               
                   case .failure(let FailResponse):
                        self.view?.hideLoading()
                        self.view?.showAlert(title: "", message: FailResponse.error ?? "")
                    
                
//                   print(FailResponse)
                   case .failureError(let error):
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
