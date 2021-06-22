//
//  GenreSelectedProtocols.swift
//  GameWO
//
//  Created by Belal medhat on 12/21/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
protocol StoreSelectedViewProtocols:BaseViewProtocol {
    var presenter:StoreSelectedPresenterProtocols? { get set }
    func reloadStoreCollection()
    var NextPage:Bool? { get set }
    var PreviousPage:Bool? { get set }
    func ChangeScrollCollectionBottom()
}



protocol StoreSelectedPresenterProtocols {
    var view:StoreSelectedViewProtocols? { get set }
    func handleViewDidLoadStore(StoreID:String,showloader:Bool,pageSize:String,Page:String,ordering:String,completionHandler: @escaping ()->()?)
    func gameStoreList() -> [Results]

}
