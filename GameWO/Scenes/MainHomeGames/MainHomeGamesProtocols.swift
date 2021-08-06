//
//  MainHomeGamesProtocols.swift
//  GameWO
//
//  Created by Belal medhat on 7/12/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
import SwiftyContextMenu
protocol MainHomeGamesViewProtocols:BaseViewProtocol {
    var presenter:MainHomeGamesPresenterProtocols? { get set }
    var NextPage:Bool? { get set }
    var PreviousPage:Bool? { get set }
    func reloadComingCollection()
    func reloadPopularCollection()
    func ChangeScrollCollectionBottom()
}
protocol MainHomeGamesPresenterProtocols {
    var view:MainHomeGamesViewProtocols? {get set}
    func handleViewDidLoadComing()
    func handleViewDidLoadPopular(showloader:Bool,pageSize:String,Page:String,ordering:String,completionHandler: @escaping ()->()?)
    func ComingList() -> [Results]
    func ScrollList() -> [Results]
    func actionFilterList() -> ContextMenu
    func AddFilterData()
    func getDatePeriod() -> String
    func ResetCollectionsList()
}
