//
//  GameGenresResponse.swift
//  GameWO
//
//  Created by Belal medhat on 9/4/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
struct GameGenresResponse:Codable{
    
  var results:[GenreResult]?
  var count:Int?
  var next:String?
  var previous:String?
}
struct GenreResult:Codable {

  var id:Int?
  var slug:String?
  var games:[Games]?
  var image_background:String?
  var name:String?
  var games_count:Int?

}
struct Games:Codable {

  var name:String?
  var slug:String?
  var id:Int?
  var added:Int?

}
