//
//  errorViewController.swift
//  GameWO
//
//  Created by Belal medhat on 12/20/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit

class errorViewController: UIViewController {
    private let radarAnimation = "radarAnimation"
      private var animationLayer: CALayer?
      private var animationGroup: CAAnimationGroup?

    @IBOutlet weak var Hand: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let first = makeRadarAnimation(showRect: CGRect(x: view.frame.minX, y: view.frame.minY, width: 200, height: 200), isRound: true) //Location and size
        first.position = view.center
        view.layer.addSublayer(first)
        view.bringSubviewToFront(Hand)
        Hand.alpha = 1
        
        // Do any additional setup after loading the view.
    }
    @IBAction func start(_ sender: UIButton) {
//        animationLayer?.add(animationGroup!, forKey: radarAnimation)

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
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
