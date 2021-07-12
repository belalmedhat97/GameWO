//
//  APIConfigurations.swift
//  GameWO
//
//  Created by Belal medhat on 6/13/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//
import Foundation

protocol APIConfiguration {
    var path: String { get }
    var parameters: RequestParams { get }
    var method: HTTPMethod { get }
    var Headers:[String:Any]? { get }
}
// MARK: - cofigure urlRequest with url and all components body ,header ,method etc...
extension APIConfiguration {
public var urlRequest: URLRequest {
    guard let url = URL(string: Endpoints.BaseUrlRawgGames) else {
    fatalError("URL could not be built")
    }
    print(url)
    var request = URLRequest(url: url.appendingPathComponent(path))
    
    
    request.httpMethod = method.rawValue

    switch parameters {

            case .body(let params):
                request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

               case .url(let params):
                let queryParams = params.map { pair  in
                           return URLQueryItem(name: pair.key, value: "\(pair.value)")
                       }
                
                var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
                components?.queryItems = queryParams
                components?.queryItems?.append(URLQueryItem(name: "key", value: "\(SecretsManager.shared.getApiKey() ?? "")"))
                
                request.url = components?.url

               case .NoParamter:
                   request.httpBody = nil

               }
    print(request)
                return request
    }
}
