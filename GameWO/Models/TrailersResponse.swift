//
//  TrailersResponse.swift
//  GameWO
//
//  Created by Belal medhat on 9/27/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
struct TrailerResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case results
    case count
  }

  var results: [TrailerResults]?
  var count: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decodeIfPresent([TrailerResults].self, forKey: .results)
    count = try container.decodeIfPresent(Int.self, forKey: .count)
  }

}
struct TrailerResults: Codable {

  enum CodingKeys: String, CodingKey {
    case data
    case id
    case name
    case preview
  }

  var data: Resolution?
  var id: Int?
  var name: String?
  var preview: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    data = try container.decodeIfPresent(Resolution.self, forKey: .data)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    preview = try container.decodeIfPresent(String.self, forKey: .preview)
  }

}

struct Resolution: Codable {
  enum CodingKeys: String, CodingKey {
    case max
    case R480 = "480"
  }

  var max: String?
  var R480: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    max = try container.decodeIfPresent(String.self, forKey: .max)
    R480 = try container.decodeIfPresent(String.self, forKey: .R480)
  }

}
