//
//  StoresApi.swift
//  GameWO
//
//  Created by Belal medhat on 9/24/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
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
       
       var Headers: [String : Any]? {
           switch self {
           case .storeList:
               return .none
           }
       }
       
     
       
}
