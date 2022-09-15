//
//  UIView+Extension.swift
//  SwiftStitch
//
//  Created by devadmin on 14/09/2022.
//

import Foundation
import UIKit

extension UIView {
    
    enum ViewSide {
        case left, right, top, bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
        case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
        case .top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
        case .bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
        }
        
        layer.addSublayer(border)
    }
    
    func applyNavBarConstraints(size: (width: CGFloat, height: CGFloat)) {
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: size.width)
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: size.height)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
    }
    
    func updateBorder(color: UIColor = .clear) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
    }
    
    func updateBorder(color: UIColor = .clear, border: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = border
    }
    
    func round() {
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
    }
    
    func round(_ round: CGFloat) {
        self.layer.cornerRadius = round
        self.layer.masksToBounds = true
    }
    
    func round(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    func  addTopBottomBoarder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let bottomBorder = CALayer()
        bottomBorder.borderColor = color
        bottomBorder.frame = CGRect(x: 0, y: frame.size.height - thickness, width: frame.size.width, height: frame.size.height)
        bottomBorder.borderWidth = thickness
        layer.addSublayer(bottomBorder)
        
    }
    
    func addShadow(toSide side: ViewSide, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        switch side {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -10), color: color, opacity: opacity, radius: radius)
        case .left:
            addShadow(offset: CGSize(width: 0, height: -10), color: color, opacity: opacity, radius: radius)
        case .right:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
