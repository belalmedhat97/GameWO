//
//  GamesApi.swift
//  GameWO
//
//  Created by Belal medhat on 7/12/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
import Alamofire
enum GamesRouter:APIConfiguration{
    case gamesListComing(dates:String,page:String,page_size:String)
    case storesGames(storeId: String, page: String, page_size: String, ordering: String)
    case gamesListOrdering(page:String,page_size:String,ordering:String)
    case gamesGenreList(genreId: String, page: String, page_size: String, ordering: String)
    case gamesGenres
    case searchGames(Value:String)
    case Screenshots(id:String)
    case Trailer(id:String)
    case gamesDetails(id:String)
    
    var method: HTTPMethod {
        switch self {
        case .gamesListOrdering(_,_,_),.gamesListComing(_,_,_),.gamesGenres,.Screenshots(_),.Trailer(_),.gamesDetails(_),.searchGames(_),.gamesGenreList(_,_,_,_),.storesGames(_,_,_,_):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .gamesListComing(_,_,_),.gamesListOrdering(_,_,_),.gamesGenreList(_,_,_,_):
            return Endpoints.gamesList
        case .gamesGenres:
            return Endpoints.genres
        case .Screenshots(let id):
            return Endpoints.gamesList + "/\(id)" + Endpoints.Screenshots
        case .Trailer(let id):
            return Endpoints.gamesList + "/\(id)" + Endpoints.Trailer
        case .gamesDetails(let id):
            return Endpoints.gamesList + "/\(id)"
        case .searchGames(_):
            return Endpoints.gamesList
        case .storesGames(_,_,_,_):
            return Endpoints.gamesList
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .gamesListComing(let dates,let page,let page_size):
            return.url(["dates":dates,"page":page,"page_size":page_size])
        case .gamesListOrdering(let page,let page_size,let ordering):
            return.url(["page":page,"page_size":page_size,"ordering":ordering])
        case .gamesGenres,.Screenshots(_),.Trailer(_),.gamesDetails(_):
            return .NoParamter
        case .searchGames(let value):
            return .url(["search":value])
        case .gamesGenreList(let Id,let page,let page_size,let ordering):
            return .url(["genres":Id,"page":page,"page_size":page_size,"ordering":ordering])
        case .storesGames(let storeId,let page,let page_size,let ordering):
            return .url(["storeId":storeId,"page":page,"page_size":page_size,"ordering":ordering])
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .gamesListComing(_,_,_),.gamesListOrdering(_,_,_),.gamesGenres,.Screenshots,.Trailer(_),.gamesDetails(_),.searchGames(_),.gamesGenreList(_,_,_,_),.storesGames(_,_,_,_):
            return .none
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
          let url = try Endpoints.BaseUrlRawgGames.asURL()
             
              var urlRequest = URLRequest(url: url.appendingPathComponent(path))
          
              // HTTP Method
              urlRequest.httpMethod = method.rawValue


              // Common Headers
              urlRequest.allHTTPHeaderFields = headers

              // Parameters
              switch parameters {
                  
              case .body(let params):

                  urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
                  print(urlRequest.httpBody)
              case .url(let params):
                      let queryParams = params.map { pair  in
                          return URLQueryItem(name: pair.key, value: "\(pair.value)")
                      }
                      var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
                      components?.queryItems = queryParams
                      urlRequest.url = components?.url
               
              case .NoParamter:
                  urlRequest.httpBody = nil
              
              }
              
                  return urlRequest
    }
    
    
}
