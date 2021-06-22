//
//  MainHomeGamesPresenter.swift
//  GameWO
//
//  Created by Belal medhat on 7/12/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
import SwiftyContextMenu
class MainHomeGamesPresenter:MainHomeGamesPresenterProtocols{
   
    
   weak var view: MainHomeGamesViewProtocols?
    private var comeList:[Results] = []
    private var scrollList:[Results] = []
    private var action:[ContextMenuAction] = []
    private var popularListOptions:[String] = ["name","released","added","created","rating"]
    init(view:MainHomeGamesViewProtocols) {
        self.view = view
    }
    func handleViewDidLoadComing() {
        self.view?.showLoading()
        NetworkCaller.Request(GamesRouter.gamesListComing(dates: getDatePeriod(), page: "1", page_size: "100")) { (result:Result<GameListResposne,Error>) in
            switch result{
             case .success(let response):
                 print(response)
                 self.comeList = response.results ?? []
                 self.view?.hideLoading()
                 self.view?.reloadComingCollection()
             case .failure(let error):
                self.view?.hideLoading()
                self.view?.showAlert(title: "", message: error.localizedDescription)
                 print(error)
             }
        }
    }
    func getDatePeriod() -> String{
         let date = Date()
         let formatter = DateFormatter()
         formatter.dateFormat = "yyyy-MM-dd"
         formatter.calendar = .current
         formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
         let StringCurrentYear = formatter.string(from: date)
         print(StringCurrentYear)
         let calendar = Calendar.current
         let comingYear = calendar.component(.year, from: date)
         
         guard let ComingYearDate = Calendar.current.date(from: DateComponents(year: comingYear + 1, month: +1, day: +2)) else { return "" }
             let comeYearDate = formatter.string(from: ComingYearDate)
             print(comeYearDate)
         return "\(StringCurrentYear),\(comeYearDate)"
         
     }
    func handleViewDidLoadPopular(showloader:Bool,pageSize:String,Page:String,ordering:String,completionHandler: @escaping ()->()?) {
        if showloader == true {
        self.view?.showLoading()
        }
        NetworkCaller.Request(GamesRouter.gamesListOrdering(page: Page, page_size: pageSize, ordering: ordering)) { (result:Result<GameListResposne,Error>) in
            switch result{
             case .success(let response):
                 print(response)
                 if response.next != nil { self.view?.NextPage = true } else {self.view?.NextPage = false}
                 if response.previous != nil { self.view?.PreviousPage = true
                    self.view?.ChangeScrollCollectionBottom()
                 } else {self.view?.PreviousPage = false
                    self.view?.ChangeScrollCollectionBottom()
                 }
                 self.scrollList = response.results ?? []
                 if showloader == true {
                    self.view?.hideLoading()
                 }
                 self.view?.reloadScrollCollection()
                completionHandler()
             case .failure(let error):
                self.view?.showAlert(title: "", message: error.localizedDescription)
                 print(error)
                completionHandler()
             }
        }
    }
    func AddFilterData(){
        // define all filter options Menu (SWiftyMenu pod)
        for filterOptionCounter in 0...popularListOptions.count - 1 {
            let Options = ContextMenuAction(title: popularListOptions[filterOptionCounter], tintColor: #colorLiteral(red: 0.4549019608, green: 0.5411764706, blue: 0.6156862745, alpha: 1)) { _ in
                self.handleViewDidLoadPopular(showloader: true, pageSize: "20", Page: "1", ordering: self.popularListOptions[filterOptionCounter], completionHandler:{})
                        }
            action.append(Options)
        }
       
   
    }
    
    
    func ComingList() -> [Results] {
        self.comeList
    }
    func ScrollList() -> [Results]{
        self.scrollList
    }
    func actionFilterList() -> ContextMenu{
         let contextMenu = ContextMenu(title: "Filter Options", actions: action)
         return contextMenu
    }
}
