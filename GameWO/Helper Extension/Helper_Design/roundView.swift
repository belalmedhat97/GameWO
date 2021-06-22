//
//  roundView.swift
//  recipeAPP
//
//  Created by belal on 9/26/19.
//  Copyright © 2019 belal. All rights reserved.
//

import UIKit

@IBDesignable class DesignView: UIView {
    @IBInspectable var roundBottomView : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = roundBottomView
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
}
    @IBInspectable var roundTopView : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = roundTopView
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    @IBInspectable var startColor: UIColor = .white {
        didSet {
            GradientColor()
            
        }
    }
    @IBInspectable var borderWidthNew: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidthNew
        
        }
    }

    @IBInspectable var borderColorNew: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColorNew.cgColor
        }
    }

    
    @IBInspectable var endColor: UIColor = .white {
        didSet {
            GradientColor()
        }
    }
    @IBInspectable var horizontalGradient: Bool = false {
        didSet {
            GradientColor()
        }
    }
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func GradientColor() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [startColor.cgColor, endColor.cgColor]
        
        if (horizontalGradient){
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        else {
            layer.startPoint = CGPoint(x: 0.0, y: 0.0)
            layer.endPoint = CGPoint(x: 0.0, y: 1.0)
        }
    }
    
    
    
}
