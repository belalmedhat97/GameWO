//
//  DataStoreManager.swift
//  GameWO
//
//  Created by Belal medhat on 6/14/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
class LocalStore {
    static let Shared = LocalStore()
    private init(){}

 func set(value: Any?, forKey key: String) {
    UserDefaults.standard.set(value, forKey: key)
}

 func get<T: Any>(for key: String, type: T.Type) -> T? {
    return UserDefaults.standard.object(forKey: key) as? T
}
 func remove(for key: String) {
    UserDefaults.standard.removeObject(forKey: key)
}

 func clearAll () {
    UserDefaults.standard.removeObject(forKey: LocalStoreKeys.token)
    UserDefaults.standard.removeObject(forKey: LocalStoreKeys.authorized)
    UserDefaults.standard.removeObject(forKey: LocalStoreKeys.objectId)
    UserDefaults.standard.removeObject(forKey: LocalStoreKeys.smsTokenValidate)
    UserDefaults.standard.removeObject(forKey: LocalStoreKeys.authVerificationID)
    UserDefaults.standard.removeObject(forKey: LocalStoreKeys.Mobilenumber)

 
}
}
