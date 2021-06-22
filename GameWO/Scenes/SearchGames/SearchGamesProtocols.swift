//
//  SearchGamesVCProtocols.swift
//  GameWO
//
//  Created by Belal medhat on 12/16/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
protocol SearchGamesViewProtocols:BaseViewProtocol {
    var presenter:SearchGamesPresenterProtocols? { get set }
    func reloadGamesCollection()
    func showError(show:Bool)

}
protocol SearchGamesPresenterProtocols {
    var view:SearchGamesViewProtocols? { get set }
    func handleDidSearch(searchValue:String)
    func gameSearchList() -> [Results]


}
