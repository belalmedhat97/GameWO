//
//  GamesDetailsResponse.swift
//  GameWO
//
//  Created by Belal medhat on 9/27/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
struct GameDetailsResponse: Codable {

  enum CodingKeys: String, CodingKey {
//    case genres
//    case publishers
//    case tags
//    case metacriticPlatforms = "metacritic_platforms"
    case youtubeCount = "youtube_count"
    case parentsCount = "parents_count"
    case requirements
    case stores
    case achievementsCount = "achievements_count"
    case redditUrl = "reddit_url"
    case redditName = "reddit_name"
    case redditDescription = "reddit_description"
    case creatorsCount = "creators_count"
    case nameOriginal = "name_original"
    case descriptionValue = "description"
    case added
//    case addedByStatus = "added_by_status"
    case reviewsCount = "reviews_count"
    case clip
//    case parentPlatforms = "parent_platforms"
    case descriptionRaw = "description_raw"
    case redditLogo = "reddit_logo"
    case moviesCount = "movies_count"
    case platforms
    case parentAchievementsCount = "parent_achievements_count"
    case screenshotsCount = "screenshots_count"
    case saturatedColor = "saturated_color"
    case metacritic
    case gameSeriesCount = "game_series_count"
    case redditCount = "reddit_count"
    case ratingTop = "rating_top"
    case backgroundImage = "background_image"
//    case developers
    case tba
    case rating
//    case ratings
    case suggestionsCount = "suggestions_count"
    case additionsCount = "additions_count"
    case twitchCount = "twitch_count"
    case released
    case name
    case id
    case website
    case playtime
    case metacriticUrl = "metacritic_url"
    case slug
//    case alternativeNames = "alternative_names"
    case dominantColor = "dominant_color"
//    case esrbRating = "esrb_rating"
    case ratingsCount = "ratings_count"
    case backgroundImageAdditional = "background_image_additional"
    case updated
    case reviewsTextCount = "reviews_text_count"
//    case reactions
  }

//  var genres: [Genres]?
//  var publishers: [Publishers]?
//  var tags: [Tags]?
//  var metacriticPlatforms: Any?
  var youtubeCount: Int?
  var parentsCount: Int?
  var requirements:[Requirements]?
  var stores: [GameStores]?
  var achievementsCount: Int?
  var redditUrl: String?
  var redditName: String?
  var redditDescription: String?
  var creatorsCount: Int?
  var nameOriginal: String?
  var descriptionValue: String?
  var added: Int?
//  var addedByStatus: AddedByStatus?
  var reviewsCount: Int?
  var clip: Clip?
//  var parentPlatforms: [ParentPlatforms]?
  var descriptionRaw: String?
  var redditLogo: String?
  var moviesCount: Int?
  var platforms: [PlatformGameDetails]?
  var parentAchievementsCount: Int?
  var screenshotsCount: Int?
  var saturatedColor: String?
  var metacritic: Int?
  var gameSeriesCount: Int?
  var redditCount: Int?
  var ratingTop: Int?
  var backgroundImage: String?
//  var developers: [Developers]?
  var tba: Bool?
  var rating: Float?
//  var ratings: [Ratings]?
  var suggestionsCount: Int?
  var additionsCount: Int?
  var twitchCount: Int?
  var released: String?
  var name: String?
  var id: Int?
  var website: String?
  var playtime: Int?
  var metacriticUrl: String?
  var slug: String?
//  var alternativeNames: Any?
  var dominantColor: String?
//  var esrbRating: EsrbRating?
  var ratingsCount: Int?
  var backgroundImageAdditional: String?
  var updated: String?
  var reviewsTextCount: Int?
//  var reactions: Reactions?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
//    genres = try container.decodeIfPresent([Genres].self, forKey: .genres)
//    publishers = try container.decodeIfPresent([Publishers].self, forKey: .publishers)
//    tags = try container.decodeIfPresent([Tags].self, forKey: .tags)
//    metacriticPlatforms = try container.decodeIfPresent([].self, forKey: .metacriticPlatforms)
    requirements = try container.decodeIfPresent([Requirements].self, forKey: .requirements)
    youtubeCount = try container.decodeIfPresent(Int.self, forKey: .youtubeCount)
    parentsCount = try container.decodeIfPresent(Int.self, forKey: .parentsCount)
    stores = try container.decodeIfPresent([GameStores].self, forKey: .stores)
    achievementsCount = try container.decodeIfPresent(Int.self, forKey: .achievementsCount)
    redditUrl = try container.decodeIfPresent(String.self, forKey: .redditUrl)
    redditName = try container.decodeIfPresent(String.self, forKey: .redditName)
    redditDescription = try container.decodeIfPresent(String.self, forKey: .redditDescription)
    creatorsCount = try container.decodeIfPresent(Int.self, forKey: .creatorsCount)
    nameOriginal = try container.decodeIfPresent(String.self, forKey: .nameOriginal)
    descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
    added = try container.decodeIfPresent(Int.self, forKey: .added)
//    addedByStatus = try container.decodeIfPresent(AddedByStatus.self, forKey: .addedByStatus)
    reviewsCount = try container.decodeIfPresent(Int.self, forKey: .reviewsCount)
    clip = try container.decodeIfPresent(Clip.self, forKey: .clip)
//    parentPlatforms = try container.decodeIfPresent([ParentPlatforms].self, forKey: .parentPlatforms)
    descriptionRaw = try container.decodeIfPresent(String.self, forKey: .descriptionRaw)
    redditLogo = try container.decodeIfPresent(String.self, forKey: .redditLogo)
    moviesCount = try container.decodeIfPresent(Int.self, forKey: .moviesCount)
    platforms = try container.decodeIfPresent([PlatformGameDetails].self, forKey: .platforms)
    parentAchievementsCount = try container.decodeIfPresent(Int.self, forKey: .parentAchievementsCount)
    screenshotsCount = try container.decodeIfPresent(Int.self, forKey: .screenshotsCount)
    saturatedColor = try container.decodeIfPresent(String.self, forKey: .saturatedColor)
    metacritic = try container.decodeIfPresent(Int.self, forKey: .metacritic)
    gameSeriesCount = try container.decodeIfPresent(Int.self, forKey: .gameSeriesCount)
    redditCount = try container.decodeIfPresent(Int.self, forKey: .redditCount)
    ratingTop = try container.decodeIfPresent(Int.self, forKey: .ratingTop)
    backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage)
//    developers = try container.decodeIfPresent([Developers].self, forKey: .developers)
    tba = try container.decodeIfPresent(Bool.self, forKey: .tba)
    rating = try container.decodeIfPresent(Float.self, forKey: .rating)
//    ratings = try container.decodeIfPresent([Ratings].self, forKey: .ratings)
    suggestionsCount = try container.decodeIfPresent(Int.self, forKey: .suggestionsCount)
    additionsCount = try container.decodeIfPresent(Int.self, forKey: .additionsCount)
    twitchCount = try container.decodeIfPresent(Int.self, forKey: .twitchCount)
    released = try container.decodeIfPresent(String.self, forKey: .released)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    website = try container.decodeIfPresent(String.self, forKey: .website)
    playtime = try container.decodeIfPresent(Int.self, forKey: .playtime)
    metacriticUrl = try container.decodeIfPresent(String.self, forKey: .metacriticUrl)
    slug = try container.decodeIfPresent(String.self, forKey: .slug)
//    alternativeNames = try container.decodeIfPresent([].self, forKey: .alternativeNames)
    dominantColor = try container.decodeIfPresent(String.self, forKey: .dominantColor)
//    esrbRating = try container.decodeIfPresent(EsrbRating.self, forKey: .esrbRating)
    ratingsCount = try container.decodeIfPresent(Int.self, forKey: .ratingsCount)
    backgroundImageAdditional = try container.decodeIfPresent(String.self, forKey: .backgroundImageAdditional)
    updated = try container.decodeIfPresent(String.self, forKey: .updated)
    reviewsTextCount = try container.decodeIfPresent(Int.self, forKey: .reviewsTextCount)
//    reactions = try container.decodeIfPresent(Reactions.self, forKey: .reactions)
  }

}
struct Requirements: Codable {

  enum CodingKeys: String, CodingKey {
    case minimum
    case recommended
  }

  var minimum: String?
  var recommended: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    minimum = try container.decodeIfPresent(String.self, forKey: .minimum)
    recommended = try container.decodeIfPresent(String.self, forKey: .recommended)
  }

}
struct PlatformGameDetails:Codable {
      enum CodingKeys: String, CodingKey {
      case platform
      case releasedAt = "released_at"
      case requirements
    }

    var platform: PlatformsCollection?
    var releasedAt: String?
    var requirements: Requirements?



    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      platform = try container.decodeIfPresent(PlatformsCollection.self, forKey: .platform)
      releasedAt = try container.decodeIfPresent(String.self, forKey: .releasedAt)
      requirements = try container.decodeIfPresent(Requirements.self, forKey: .requirements)
    }

}
struct PlatformsCollection: Codable {

  enum CodingKeys: String, CodingKey {
    case name
    case gamesCount = "games_count"
    case imageBackground = "image_background"
    case id
    case slug
  }

  var name: String?
  var gamesCount: Int?
  var imageBackground: String?
  var id: Int?
  var slug: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    gamesCount = try container.decodeIfPresent(Int.self, forKey: .gamesCount)
    imageBackground = try container.decodeIfPresent(String.self, forKey: .imageBackground)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    slug = try container.decodeIfPresent(String.self, forKey: .slug)
  }

}
struct GameStores:Codable {
    
    var store: Store?
    var id: Int?
    var url: String?
}
