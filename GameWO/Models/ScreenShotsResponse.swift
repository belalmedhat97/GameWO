//
//  ScreenShotsResponse.swift
//  GameWO
//
//  Created by Belal medhat on 9/27/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
struct ScreenShots: Codable {

  enum CodingKeys: String, CodingKey {
    case results
    case count
  }

  var results: [ScreenShotsResults]?
  var count: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decodeIfPresent([ScreenShotsResults].self, forKey: .results)
    count = try container.decodeIfPresent(Int.self, forKey: .count)
  }

}
struct ScreenShotsResults: Codable {

  enum CodingKeys: String, CodingKey {
    case height
    case isDeleted = "is_deleted"
    case width
    case id
    case image
  }

  var height: Int?
  var isDeleted: Bool?
  var width: Int?
  var id: Int?
  var image: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    height = try container.decodeIfPresent(Int.self, forKey: .height)
    isDeleted = try container.decodeIfPresent(Bool.self, forKey: .isDeleted)
    width = try container.decodeIfPresent(Int.self, forKey: .width)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    image = try container.decodeIfPresent(String.self, forKey: .image)
  }

}
