//
//  EndpointsConstant.swift
//  GameWO
//
//  Created by Belal medhat on 6/13/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
struct Endpoints {
 // User registration Api using https://www.back4app.com
static let Application_Id = "lv53NylcJAI79e2CdLINSwWcSBXDXj2vQ2bgpCvx"
static let Api_key = "hwYyYbgWjSiSbJkXqZYYk0J3hgwm9NnCrgVnSkLK"
 // basic user registration
static let baseURLUser = "https://parseapi.back4app.com"
static let SignUp = "/users"
static let SignIn = "/login"
static let UserDetails = "/users/me"
static let UpdateUser = "/users/"
static let EmailVerification = "/verificationEmailRequest"
static let requestPasswordReset = "/users/restorepassword/"
    
// Games Data Api https://rawg.io/
static let BaseUrlRawgGames = "https://api.rawg.io/api"
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
