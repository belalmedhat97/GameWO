//
//  BaseDesign.swift
//  GameWO
//
//  Created by Belal medhat on 6/11/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
    
}
@IBDesignable
class DesignableTextField: UITextField {
    @IBInspectable var leftImage: UIImage? {
         didSet {
             updateView()
         }
     }

     @IBInspectable var leftPadding: CGFloat = 0 {
         didSet {
             updateView()
         }
     }

     @IBInspectable var rightImage: UIImage? {
         didSet {
             updateView()
         }
     }
     @IBInspectable var color: UIColor = UIColor.lightGray {
              didSet {
                  updateView()
              }
          }

     @IBInspectable var rightPadding: CGFloat = 0 {
         didSet {
             updateView()
         }
     }

     private var _isRightViewVisible: Bool = true
     var isRightViewVisible: Bool {
         get {
             return _isRightViewVisible
         }
         set {
             _isRightViewVisible = newValue
             updateView()
         }
     }

     func updateView() {
         setLeftImage()
         setRightImage()

         // Placeholder text color

                attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
        
     }

     func setLeftImage() {
         leftViewMode = UITextField.ViewMode.always
         var view: UIView

         if let image = leftImage {
             let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
             imageView.image = image
             imageView.contentMode = .scaleAspectFit
             // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
             imageView.tintColor = tintColor

             var width = imageView.frame.width + leftPadding

             if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                 width += 5
             }

             view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
             view.addSubview(imageView)
         } else {
             view = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 20))
         }

         leftView = view
     }

     func setRightImage() {
         rightViewMode = UITextField.ViewMode.always

         var view: UIView

         if let image = rightImage, isRightViewVisible {
             let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
             imageView.image = image
             // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
             imageView.tintColor = tintColor

             var width = imageView.frame.width + rightPadding

             if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                 width += 5
             }

             view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
             view.addSubview(imageView)

         } else {
             view = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: 20))
         }

         rightView = view
     }
}


@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            }
    }
    @IBInspectable
    var cornerTop: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
           
            layer.cornerRadius = newValue
            }
    }
    @IBInspectable
    var cornerBottom: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
             layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            layer.cornerRadius = newValue
            }
    }


    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
extension UIView{
    
    func BounceAnimation(Object:UIView,callback: @escaping ()->()?){
    Object.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.7,delay: 0,usingSpringWithDamping: CGFloat(0.20),initialSpringVelocity: CGFloat(6.0),options: UIView.AnimationOptions.allowUserInteraction,animations: {
        Object.transform = CGAffineTransform.identity
        },completion: { Void in(
            callback()
            )  }
             )
    }
}
extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
