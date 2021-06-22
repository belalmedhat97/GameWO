//
//  RoundImages.swift
//  recipeAPP
//
//  Created by belal on 9/26/19.
//  Copyright © 2019 belal. All rights reserved.
//

import UIKit

@IBDesignable class DesignImage: UIImageView {
    @IBInspectable var roundCornerTopImage : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = roundCornerTopImage
//            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
}

