//
//  BaseProtocols.swift
//  Mizzony
//
//  Created by Belal medhat on 8/24/19.
//  Copyright © 2019 Belal medhat. All rights reserved.
//
import SDWebImage
protocol BaseViewProtocol: AnyObject {    
    func showLoading()
    func hideLoading()
    func showAlert(title: String?, message: String)
    func SystemModeCheck()
    func NetworkAvailability()
    func GoVC(Storyboard: String, Screen: String,Present:Bool)
    func ReturnVC(Present:Bool)
    func IndicatorColor() -> SDWebImageActivityIndicator
    func AnimateLogo(LogoView:UIView)
}
