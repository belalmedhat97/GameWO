//
//  StoresApi.swift
//  GameWO
//
//  Created by Belal medhat on 9/24/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
import Alamofire
enum StoreRouter:APIConfiguration{

    case storeList
    
    var method: HTTPMethod {
           switch self {
           case .storeList:
               return .get
           }
       }
       
       var path: String {
           switch self {
           case .storeList:
               return Endpoints.storeList
           }
       }
       
       var parameters: RequestParams {
           switch self {
           case .storeList:
               return .NoParamter
           }
       }
       
       var headers: [String : String]? {
           switch self {
           case .storeList:
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
