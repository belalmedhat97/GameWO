//
//  PlacholderColor.swift
//  marrketplaceBSB
//
//  Created by Belal medhat on 4/28/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
@IBDesignable class DesignText:UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
     override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
            var textRect = super.leftViewRect(forBounds: bounds)
            textRect.origin.x += leftPadding
            return textRect
        }

        @IBInspectable var leftImage: UIImage? {
            didSet {
                updateView()
            }
        }

        @IBInspectable var leftPadding: CGFloat = 0

        @IBInspectable var color: UIColor = UIColor.lightGray {
            didSet {
                updateView()
            }
        }

        func updateView() {
            if let image = leftImage {
                leftViewMode = UITextField.ViewMode.always
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                imageView.image = image
                // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
                imageView.tintColor = color
                leftView = imageView
            } else {
                leftViewMode = UITextField.ViewMode.never
                leftView = nil
            }

            // Placeholder text color
            attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
        }
    }

