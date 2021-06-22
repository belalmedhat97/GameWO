//
//  UserApi.swift
//  GameWO
//
//  Created by Belal medhat on 6/13/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
import Alamofire
enum UserRouter:APIConfiguration {
      
    
    case SignIn(username:String,password:String)
    case SignUp(username:String,email:String,password:String,phone:String)
    case verificationEmail(email:String)
    case passwordReset(email:String)
    case updateUser(username:String,email:String,phone:String)
    case UserDetails
    
    var method: HTTPMethod {
        switch self {
        case .UserDetails,.passwordReset,.SignIn:
            return .get
        case .verificationEmail,.SignUp:
            return .post
        case .updateUser:
            return .put
        }
    }
    
    var path: String {
        switch self {
        case .SignIn(_,_):
           return Endpoints.SignIn
        case .SignUp(_,_,_,_):
            return Endpoints.SignUp
        case .updateUser(_,_,_):
            return Endpoints.UpdateUser + (LocalStore.Shared.get(for: LocalStoreKeys.objectId, type: String.self) ?? "")
        case .verificationEmail(_):
            return Endpoints.EmailVerification
        case .UserDetails:
            return Endpoints.UserDetails + (LocalStore.Shared.get(for: LocalStoreKeys.objectId, type: String.self) ?? "")
        case .passwordReset(let email):
            return Endpoints.requestPasswordReset + email
        }
    }
    var headers: [String : String]? {
           switch self {
           case .SignIn(_,_),.verificationEmail(_),.passwordReset(_),.updateUser(_,_,_),.UserDetails:
               return
                [ "\(HTTPHeaderField.Parse_application_id.rawValue)":"\(Endpoints.Application_Id)",
                    "\(HTTPHeaderField.Parse_apikey.rawValue)":"\(Endpoints.Api_key)"
                ]
           case .SignUp(_,_,_,_):
            return
                [ "\(HTTPHeaderField.Parse_application_id.rawValue)":"\(Endpoints.Application_Id)",
                    "\(HTTPHeaderField.Parse_apikey.rawValue)":"\(Endpoints.Api_key)",
                    "\(HTTPHeaderField.contentType.rawValue)":"\(ContentType.json.rawValue)"
                ]
          }
        
       }
    
    var parameters: RequestParams {
        switch self {
        case .SignUp(let username, let email, let password,let phone):
            return .body(["username":username,"email":email,"password":password,"phone":phone])
        case .verificationEmail(let email):
            return .body(["email":email])
        case .passwordReset(_):
            return .NoParamter
        case .updateUser(let username, let email,let phone):
            return .body(["name":username,"email":email,"phone":phone])
        case .UserDetails:
            return .url(["props":"email,name,phone"])
        case .SignIn(let username, let password):
            return .url(["username":username,"password":password])
        }
    }
    var encoding: ParameterEncoding {
        return JSONEncoding.default
      }
      
    
    func asURLRequest() throws -> URLRequest {
        let url = try Endpoints.baseURLUser.asURL()
       
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
    

