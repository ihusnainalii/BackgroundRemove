//
//  IBDesignableView.swift
//  Background Remover
//
//  Created by devadmin on 11/11/2021.
//

import Foundation
import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            } else {
                return nil
            }
        }
        set {
            layer.borderColor = newValue!.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var cornerRadius:CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
    }
    
    @IBInspectable var cornerRadTL:CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            if #available(iOS 11.0, *) {
                layer.maskedCorners = [.layerMinXMinYCorner]
            } else {
                // Fallback on earlier versions
            }
            clipsToBounds = newValue > 0
        }
    }
    
    @IBInspectable var cornerRadTR:CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            if #available(iOS 11.0, *) {
                layer.maskedCorners = [.layerMaxXMinYCorner]
            } else {
                // Fallback on earlier versions
            }
            clipsToBounds = newValue > 0
        }
    }
    
    @IBInspectable var cornerRadBL: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            if #available(iOS 11.0, *) {
                layer.maskedCorners = [.layerMinXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
            clipsToBounds = newValue > 0
        }
    }

    @IBInspectable var cornerRadBR: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            if #available(iOS 11.0, *) {
                layer.maskedCorners = [.layerMaxXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
            clipsToBounds = newValue > 0
        }
    }
    
    @IBInspectable var corBRTR: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            if #available(iOS 11.0, *) {
                layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
            clipsToBounds = newValue > 0
        }
    }

    @IBInspectable var corBLTL:CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            if #available(iOS 11.0, *) {
                layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
            clipsToBounds = newValue > 0
        }
    }
    
    @IBInspectable var padding:CGFloat {
        get {
            return self.bounds.origin.x
        }
        set {
            self.bounds = self.frame.insetBy(dx: newValue, dy: padding)
        }
    }
    
    class func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil, owner: AnyObject) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
        ).instantiate(withOwner: owner, options: nil)[0] as? UIView
    }
}
