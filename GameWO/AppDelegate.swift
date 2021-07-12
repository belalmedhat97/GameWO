//
//  AppDelegate.swift
//  GameWO
//
//  Created by Belal medhat on 6/6/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import DropDown
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DropDown.startListeningToKeyboard()
        IQKeyboardManager.shared.enable = true
        return true
    }
    
    
       

// MARK: - notify when user return back to app
     func applicationWillEnterForeground(_ application: UIApplication) {
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("userReturnBack"), object: nil)
    }
}
