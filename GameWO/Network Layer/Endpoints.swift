//
//  EndpointsConstant.swift
//  GameWO
//
//  Created by Belal medhat on 6/13/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
struct Endpoints {

// Games Data Api https://rawg.io/
    
static let BaseUrlRawgGames = "https://api.rawg.io/api?key=\(SecretsManager.shared.getApiKey() ?? "")"
static let genres = "/genres"
static let genresDetails = "/genres/"
static let gamesList = "/games"
static let gamesDetails = "/games/"
static let storeList = "/stores"
static let LikeGame = "/LikedGames"
static let Screenshots = "/screenshots"
static let Trailer = "/movies"
static let Search = "/search"

}
