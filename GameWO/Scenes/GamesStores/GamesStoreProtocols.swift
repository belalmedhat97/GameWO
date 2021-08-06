//
//  GamesStoreProtocols.swift
//  GameWO
//
//  Created by Belal medhat on 9/24/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation

protocol GamesStoreViewProtocol:BaseViewProtocol {
    var presenter:GamesStorePresenterProtocol? { get set }
    func reloadStoreCollection()
    
}
protocol GamesStorePresenterProtocol {
    var view:GamesStoreViewProtocol? { get set }
    func handleViewDidLoad()
    func StoreList() -> [StoreResults]
    func ResetStoreList()

}
