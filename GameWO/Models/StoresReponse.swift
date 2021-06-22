//
//  StoresReponse.swift
//  GameWO
//
//  Created by Belal medhat on 9/24/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
struct GamesStoreResponse:Codable{

      enum CodingKeys: String, CodingKey {
        case seoH1 = "seo_h1"
        case seoDescription = "seo_description"
        case count
        case seoTitle = "seo_title"
        case descriptionValue = "description"
        case results
      }

      var seoH1: String?
      var seoDescription: String?
      var count: Int?
      var seoTitle: String?
      var descriptionValue: String?
      var results: [StoreResults]?



      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        seoH1 = try container.decodeIfPresent(String.self, forKey: .seoH1)
        seoDescription = try container.decodeIfPresent(String.self, forKey: .seoDescription)
        count = try container.decodeIfPresent(Int.self, forKey: .count)
        seoTitle = try container.decodeIfPresent(String.self, forKey: .seoTitle)
        descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
        results = try container.decodeIfPresent([StoreResults].self, forKey: .results)
      }

    }


struct StoreResults: Codable {

  enum CodingKeys: String, CodingKey {
    case games
    case slug
    case following
    case imageBackground = "image_background"
    case name
    case domain
    case id
    case gamesCount = "games_count"
  }

  var games: [StoreGames]?
  var slug: String?
  var following: Bool?
  var imageBackground: String?
  var name: String?
  var domain: String?
  var id: Int?
  var gamesCount: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    games = try container.decodeIfPresent([StoreGames].self, forKey: .games)
    slug = try container.decodeIfPresent(String.self, forKey: .slug)
    following = try container.decodeIfPresent(Bool.self, forKey: .following)
    imageBackground = try container.decodeIfPresent(String.self, forKey: .imageBackground)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    domain = try container.decodeIfPresent(String.self, forKey: .domain)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    gamesCount = try container.decodeIfPresent(Int.self, forKey: .gamesCount)
  }

}

struct StoreGames: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case added
    case slug
    case name
  }

  var id: Int?
  var added: Int?
  var slug: String?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    added = try container.decodeIfPresent(Int.self, forKey: .added)
    slug = try container.decodeIfPresent(String.self, forKey: .slug)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
