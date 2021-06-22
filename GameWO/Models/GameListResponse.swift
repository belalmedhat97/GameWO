//
//  GameListResponse.swift
//  GameWO
//
//  Created by Belal medhat on 7/12/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
struct GameListResposne: Codable {
      var seo_description: String?
      var nofollow_collections: [String]?
      var noindex: Bool?
      var results: [Results]?
      var seo_keywords: String?
      var next: String?
      var seo_title: String?
      var previous: String?
      var seo_h1: String?
      var filters: Filters?
      var count: Int?
      var description: String?
      var nofollow: Bool?
}
struct Filters:Codable {
     var years: [Years]?
}
struct Results:Codable {
    
      var released: String?
      var platforms: [Platforms]?
      var suggestions_count: Int?
      var id: Int?
      var background_image: String?
      var reviews_text_count: Int?
      var clip: Clip?
      var rating_top: Int?
      var tags: [Tags]?
      var name: String?
      var stores: [Stores]?
      var genres: [Genres]?
      var playtime: Int?
      var added_by_status: AddedByStatus?
      var parent_platforms: [ParentPlatforms]?
      var rating: Float?
      var slug: String?
      var dominant_color: String?
      var short_screenshots: [ShortScreenshots]?
      var ratings: [Ratings]?
      var reviews_count: Int?
      var ratings_count: Int?
      var saturated_color: String?
      var metacritic: Int?
      var added: Int?
      var tba: Bool?

}
struct Years:Codable {
    var nofollow: Bool?
    var year: Int?
    var count: Int?

}
struct Platforms:Codable {

    var platform: Platform?
    var requirements_en: RequirementsEn?
    var released_at: String?
    var requirements_ru: RequirementsRu?
}
struct Clip:Codable {
    var clip: String?
    var preview: String?
    var video: String?
    var clips: Clips?
}
struct Clips:Codable {
    enum CodingKeys: String, CodingKey {
      case Video320 = "320"
      case full
      case Video640 = "640"
    }

    var Video320: String?
    var full: String?
    var Video640: String?



    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      Video320 = try container.decodeIfPresent(String.self, forKey: .Video320)
      full = try container.decodeIfPresent(String.self, forKey: .full)
      Video640 = try container.decodeIfPresent(String.self, forKey: .Video640)
    }


}
struct Tags:Codable {
    var name: String?
    var image_background: String?
    var slug: String?
    var games_count: Int?
    var language: String?
    var id: Int?
}
struct Stores:Codable {
    
    var store: Store?
    var id: Int?
    var url_en: String?
}
struct Genres:Codable {

    var games_count: Int?
    var name: String?
    var id: Int?
    var slug: String?
    var image_background: String?

}
struct AddedByStatus:Codable {
    var playing: Int?
    var yet: Int?
    var owned: Int?
    var dropped: Int?
    var toplay: Int?
    var beaten: Int?

}
struct ParentPlatforms:Codable {
      var platform: Platform?
}
struct ShortScreenshots:Codable {
    var id: Int?
    var image: String?

}
struct Ratings:Codable {
    var id: Int?
    var title: String?
    var percent: Float?
    var count: Int?

}
struct Platform:Codable {
    
    var name: String?
    var slug: String?
    var id: Int?

}
struct RequirementsEn:Codable {
    
    var recommended: String?
    var minimum: String?
}
struct RequirementsRu:Codable {
    var recommended: String?
    var minimum: String?
}
struct Store:Codable {
    var id: Int?
    var domain: String?
    var games_count: Int?
    var image_background: String?
    var name: String?
    var slug: String?

}
struct ErrorResponse:Codable,Error {
    var detail:String?
}

