//
//  RoundAllVIew.swift
//  TestBigSilly
//
//  Created by Belal medhat on 1/27/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
@IBDesignable class DesignALLView:UIView {

@IBInspectable var roundCorner : CGFloat = 0.0 {
    didSet {
        self.layer.cornerRadius = roundCorner
    }
}

}
