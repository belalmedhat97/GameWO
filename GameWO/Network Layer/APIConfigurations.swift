//
//  APIConfigurations.swift
//  GameWO
//
//  Created by Belal medhat on 6/13/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//
import Alamofire
import Foundation
protocol APIConfiguration:URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
    var headers: [String: String]? { get }
    var encoding: ParameterEncoding { get }

}
enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case Parse_application_id = "X-Parse-Application-Id"
    case Parse_apikey = "X-Parse-REST-API-Key"
}

enum ContentType: String {
    case json = "Application/json"
}


enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
    case NoParamter
}
