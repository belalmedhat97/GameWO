//
//  BaseViewControllerDesign.swift
//  GameWO
//
//  Created by Belal medhat on 6/21/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
extension BaseViewController{
   func Loader(removeFromView:Bool){

        guard removeFromView == false else {
            ViewCenter.removeFromSuperview()
            Indicator.removeFromSuperview()
            return }
        self.view.addSubview(ViewCenter)
        ViewCenter.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9568627451, blue: 0.9725490196, alpha: 1)
        ViewCenter.borderWidth = 2
        ViewCenter.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        ViewCenter.cornerRadius = 10
        ViewCenter.clipsToBounds = true
              ViewCenter.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate(
                  [ViewCenter.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                   ViewCenter.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                   ViewCenter.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
              ViewCenter.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3)])
              
        
        self.ViewCenter.addSubview(Indicator)
        Indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [Indicator.centerYAnchor.constraint(equalTo: self.ViewCenter.centerYAnchor),
             Indicator.centerXAnchor.constraint(equalTo: self.ViewCenter.centerXAnchor)])
        
    }
    func NetworkViewIntializer(show:Bool){
        if show == true {
            UIApplication.shared.keyWindow!.addSubview(NetworkView) // made Network  error cover all view with the tabbar
            UIApplication.shared.keyWindow!.bringSubviewToFront(NetworkView)
            
            let HandImage = UIImageView(frame: CGRect(x: NetworkView.frame.midX, y: NetworkView.frame.midY, width: 150, height: 150))
            let NetworkErrorMessege1 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
                       NetworkErrorMessege1.textColor = #colorLiteral(red: 0.6509803922, green: 0.737254902, blue: 0.8156862745, alpha: 1)
                       NetworkErrorMessege1.numberOfLines = 0
                       NetworkErrorMessege1.font = UIFont.init(name: "arial", size: 40)
                       NetworkErrorMessege1.textAlignment = .center
                       NetworkErrorMessege1.text = "NO INTERNET"
                       NetworkView.addSubview(NetworkErrorMessege1)
                       NetworkErrorMessege1.translatesAutoresizingMaskIntoConstraints = false
                                  NSLayoutConstraint.activate(
                                      [
                                       NetworkErrorMessege1.centerXAnchor.constraint(equalTo: self.NetworkView.centerXAnchor),
                                       NetworkErrorMessege1.leftAnchor.constraint(equalTo: self.NetworkView.leftAnchor, constant: 10),
                                       NetworkErrorMessege1.rightAnchor.constraint(equalTo: self.NetworkView.rightAnchor, constant: -10),
                                       NetworkErrorMessege1.heightAnchor.constraint(equalToConstant: 60),NetworkErrorMessege1.topAnchor.constraint(equalTo: NetworkView.topAnchor, constant: 40)])
            let NetworkErrorMessege2 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            NetworkErrorMessege2.textColor = #colorLiteral(red: 0.6509803922, green: 0.737254902, blue: 0.8156862745, alpha: 1)
            NetworkErrorMessege2.numberOfLines = 0
            NetworkErrorMessege2.font.withSize(40)
            NetworkErrorMessege2.textAlignment = .center
            NetworkErrorMessege2.text = "Seemed To Be No Internet Acess Check Your Wifi or Cellular Connection And Try Again"
            NetworkView.addSubview(NetworkErrorMessege2)
            NetworkErrorMessege2.translatesAutoresizingMaskIntoConstraints = false
                       NSLayoutConstraint.activate(
                           [
                            NetworkErrorMessege2.centerXAnchor.constraint(equalTo: self.NetworkView.centerXAnchor),
                            NetworkErrorMessege2.leftAnchor.constraint(equalTo: self.NetworkView.leftAnchor, constant: 10),
                            NetworkErrorMessege2.rightAnchor.constraint(equalTo: self.NetworkView.rightAnchor, constant: -10),
                            NetworkErrorMessege2.heightAnchor.constraint(equalToConstant: 60),NetworkErrorMessege2.bottomAnchor.constraint(equalTo: NetworkView.bottomAnchor, constant: -30)])
            HandImage.image = UIImage(named: "PhoneInHand")
            HandImage.center = NetworkView.center
            HandImage.contentMode = .scaleAspectFit
            
        NetworkView.backgroundColor = UIColor.init(named: "BackGroundApp")
        NetworkView.addSubview(HandImage)
        let first = makeRadarAnimation(showRect: CGRect(x: NetworkView.frame.minX, y: NetworkView.frame.minY, width: 200, height: 200), isRound: true) //Location and size
              first.position = NetworkView.center
              NetworkView.layer.addSublayer(first)
              NetworkView.bringSubviewToFront(HandImage)
        }else{

            NetworkView.removeFromSuperview()
        }
        
    }
            private func makeRadarAnimation(showRect: CGRect, isRound: Bool) -> CALayer {
                         // 1. A dynamic wave
                let shapeLayer = CAShapeLayer()
                shapeLayer.frame = showRect
                         // showRect maximum inscribed circle
            
             shapeLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: showRect.width, height: showRect.height)).cgPath
                 
                         shapeLayer.fillColor = #colorLiteral(red: 0.5401973128, green: 0.9296894073, blue: 0.6209766269, alpha: 1)  //Ripple color
                         shapeLayer.opacity = 0.0 // default initial color transparency
                
                animationLayer = shapeLayer
                
                         // 2. Need to repeat the dynamic wave, that is, create a copy
                let replicator = CAReplicatorLayer()
                replicator.frame = shapeLayer.bounds
                replicator.instanceCount = 4
                replicator.instanceDelay = 1.0
                replicator.addSublayer(shapeLayer)
                
                         // 3. Create an animation group
                let opacityAnimation = CABasicAnimation(keyPath: "opacity")
                         opacityAnimation.fromValue = NSNumber(floatLiteral: 1.0) // Start transparency
                         opacityAnimation.toValue = NSNumber(floatLiteral: 0) // Transparent bottom at the end
                
                let scaleAnimation = CABasicAnimation(keyPath: "transform")
                if isRound {
                                 scaleAnimation.fromValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0)) // Zoom start size
                } else {
                                 scaleAnimation.fromValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 0)) // Zoom start size
                }
                         scaleAnimation.toValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 2.0, 2.0, 0)) // Zoom end size
                
                let animationGroup = CAAnimationGroup()
                animationGroup.animations = [opacityAnimation, scaleAnimation]
                         animationGroup.duration = 3.0 // Animation execution time
                         animationGroup.repeatCount = HUGE // maximum repeat
                animationGroup.autoreverses = false
                
                self.animationGroup = animationGroup
                
                shapeLayer.add(animationGroup, forKey: radarAnimation)
                
                return replicator
            }
         
         

    
}
