//
//  RoundButton.swift
//  TestBigSilly
//
//  Created by Belal medhat on 1/26/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit

@IBDesignable class DesignButton: UIButton {
    
    @IBInspectable var roundCorner : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = roundCorner
        }
    }
    @IBInspectable var BorderColor : UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    @IBInspectable var BorderWidth : CGFloat = 0.0 {
          didSet {
              self.layer.borderWidth = BorderWidth
          }
      }
    @IBInspectable var BorderBottomWidth : CGFloat = 0.0 {
          didSet {
            self.layer.borderWidth = BorderBottomWidth
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

          }
      }

}
