//
//  GenreSelectedProtocols.swift
//  GameWO
//
//  Created by Belal medhat on 12/21/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
protocol GenreSelectedViewProtocols:BaseViewProtocol {
    var presenter:GenreSelectedPresenterProtocols? { get set }
    func reloadGenreCollection()
    var NextPage:Bool? { get set }
    var PreviousPage:Bool? { get set }
    func ChangeScrollCollectionBottom()
}



protocol GenreSelectedPresenterProtocols {
    var view:GenreSelectedViewProtocols? { get set }
    func handleViewDidLoadGenre(Genre:String,showloader:Bool,pageSize:String,Page:String,ordering:String,completionHandler: @escaping ()->()?)
    func gameGenreList() -> [Results]

}
