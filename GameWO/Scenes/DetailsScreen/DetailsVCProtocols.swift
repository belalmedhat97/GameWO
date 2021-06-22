//
//  DetailsVCProtocols.swift
//  GameWO
//
//  Created by Belal medhat on 9/27/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
protocol DetailsVCViewProtocols:BaseViewProtocol{
    var presenter:DetailsVCPresenterProtocols? { get set }
    func reloadScreenshots()
    func reloadTrailerVideos()
    func reloadPlatforms()
    func reloadStores()
    func reloadVCDetails(Details:GameDetailsResponse)
    func removeTrailerCollection()

}
protocol DetailsVCPresenterProtocols{
    var view:DetailsVCViewProtocols? { get set }
    func ViewDidLoadDetails(id:String)
    func ViewDidLoadScreenshots(id:String)
    func ViewDidLoadTrailer(id:String)
    
    func ScreenshotsLists() -> [ScreenShotsResults]
    func TrailerList() -> [TrailerResults]
    func Platforms() -> [PlatformGameDetails]
    func Stores() -> [GameStores]


}
