//
//  RoundLabels.swift
//  recipeAPP
//
//  Created by belal on 9/17/19.
//  Copyright © 2019 belal. All rights reserved.
//

import UIKit

@IBDesignable class DesignLabel: UILabel {
    
    @IBInspectable var roundCorner : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = roundCorner
        }
    }
    
}

