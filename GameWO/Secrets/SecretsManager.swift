//
//  SecretsManager.swift
//  GameWO
//
//  Created by belal medhat on 11/07/2021.
//  Copyright © 2021 Belal medhat. All rights reserved.
//

import Foundation
// MARK:- here reads api key form Xcconfig file to reduce the risk of exposing the api key

class SecretsManager{
    
    // singleton pattern
    static let shared:SecretsManager = SecretsManager()
    
    private init(){}
    
    func getApiKey() -> String?{
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "Game_API_Key") as? String
            
            // 2
        guard let key = apiKey, !key.isEmpty else {
                
            // 3
                print("API key does not exist")
                return nil
            }
            // 4
        return key
        }
}

