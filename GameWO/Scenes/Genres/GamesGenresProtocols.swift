//
//  GamesGenresProtocols.swift
//  GameWO
//
//  Created by Belal medhat on 9/4/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
protocol GamesGenresViewProtocols:BaseViewProtocol {
    var presenter:GamesGenresPresenterProtocols? { get set }
    func reloadGenreCollection()
}
protocol GamesGenresPresenterProtocols {
    var view:GamesGenresViewProtocols? {get set}
    func handleViewDidLoad()
    func GenreList() -> [GenreResult]
    func ResetGenreList()

}
