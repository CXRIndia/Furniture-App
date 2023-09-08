//
//  UIView.swift
//  eprocessify-ios
//
//  Created by Apple on 05/12/19.
//  Copyright © 2019 CodeToArt Technology Pvt. Ltd. All rights reserved.
//


import Foundation
import UIKit

extension UIView {
    
    func roundTop(radius:CGFloat = 20){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }

    func roundBottom(radius:CGFloat = 5){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
   
    func roundCornersWithLayerMask(cornerRadii: CGFloat, corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
      }
    
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(
                width: radius,
                height: radius
            )
        )
        self.clipsToBounds = true
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func roundedCorner(height:CGFloat,color:UIColor)  {
        self.clipsToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = height / 2
    }

    func setBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }

    func setBottomBorder(color: UIColor, height: CGFloat) {
        let border = CALayer()
        border.frame = CGRect(
            x: 0,
            y: self.bounds.height - height,
            width:  self.bounds.width,
            height: height
        )
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
        border.zPosition = 1
    }

    func setTopBorder(color: UIColor, height: CGFloat) {
        let border = CALayer()
        border.frame = CGRect.init(
            x: 0,
            y: 0,
            width: self.bounds.width,
            height: height
        )
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
        border.masksToBounds = true
        border.zPosition = 1
    }

    func setBottomBoreder(color: UIColor, height: CGFloat) {
        let border = CALayer()
        border.frame = CGRect.init(
            x: 0,
            y: self.bounds.height - height,
            width: self.bounds.width,
            height: height
        )
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
        border.zPosition = 1
    }

    func setCornerRadius(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }

    func addShadowToViewFor(color: UIColor = UIColor.gray, cornerRadius: CGFloat) {
        self.backgroundColor = .white
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 5
    }


    func addShadowToView(color: UIColor? = .darkGray) {
        let shadowPath = UIBezierPath(rect: self.bounds)
        layer.masksToBounds = false
        layer.shadowColor = color?.cgColor
        layer.shadowOffset = CGSize(width: 0,height: 0)
        layer.shadowOpacity = 0.6
        //layer.shadowRadius = 8.0
        layer.cornerRadius = 5
        layer.shadowPath = shadowPath.cgPath

    }
    
   

    func addShadowToView(color: UIColor = UIColor.gray, cornerRadius: CGFloat) {
       
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 5
    }
    
    func addShadowToViewForCell(color: UIColor = UIColor.gray, cornerRadius: CGFloat) {
       
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 2
    }

    func addShadowToView(color: UIColor = UIColor.gray, cornerRadius: CGFloat,backgroundColor: UIColor = .white,offset:Int) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: offset)
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 10
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively

    }

    func constraintsEqualToSuperView() {
        if let superview = self.superview {
            NSLayoutConstraint.activate(
                [
                    self.topAnchor.constraint(
                        equalTo: superview.topAnchor
                    ),
                    self.bottomAnchor.constraint(
                        equalTo: superview.bottomAnchor
                    ),
                    self.leadingAnchor.constraint(
                        equalTo: superview.leadingAnchor
                    ),
                    self.trailingAnchor.constraint(
                        equalTo: superview.trailingAnchor
                    )
                ]
            )
        }
    }

    func constraintsEqualToSuperViewWithMargins() {
        if let superview = self.superview {
            NSLayoutConstraint.activate(
                [
                    self.topAnchor.constraint(
                        equalTo: superview.layoutMarginsGuide.topAnchor
                    ),
                    self.bottomAnchor.constraint(
                        equalTo: superview.bottomAnchor
                    ),
                    self.leadingAnchor.constraint(
                        equalTo: superview.leadingAnchor
                    ),
                    self.trailingAnchor.constraint(
                        equalTo: superview.trailingAnchor
                    )
                ]
            )
        }
    }

    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.init(white: 1.0, alpha: 0.0).cgColor,
                           UIColor.init(white: 1.0, alpha: 0.2).cgColor,
                           UIColor.init(white: 1.0, alpha: 1.0).cgColor]   // your colors go here
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }

}

extension UIButton {
   func selectedButton(title:String, iconName: String, widthConstraints: NSLayoutConstraint){
   self.backgroundColor = UIColor(red: 0, green: 118/255, blue: 254/255, alpha: 1)
   self.setTitle(title, for: .normal)
   self.setTitle(title, for: .highlighted)
   self.setTitleColor(UIColor.white, for: .normal)
   self.setTitleColor(UIColor.white, for: .highlighted)
   self.setImage(UIImage(named: iconName), for: .normal)
   self.setImage(UIImage(named: iconName), for: .highlighted)
   let imageWidth = self.imageView!.frame.width
    let textWidth = (title as NSString).size(withAttributes:[NSAttributedString.Key.font:self.titleLabel!.font!]).width
   let width = textWidth + imageWidth + 24
   //24 - the sum of your insets from left and right
   widthConstraints.constant = width
   self.layoutIfNeeded()
   }
}

extension UIView {

    /// Adds bottom border to the view with given side margins
    ///
    /// - Parameters:
    ///   - color: the border color
    ///   - margins: the left and right margin
    ///   - borderLineSize: the size of the border
    func addBottomBorder(color: UIColor = UIColor.red, margins: CGFloat = 0, borderLineSize: CGFloat = 1) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .height,
                                                multiplier: 1, constant: borderLineSize))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .leading,
                                              multiplier: 1, constant: margins))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .trailing,
                                              multiplier: 1, constant: margins))
    }
}

extension UIView {
func hideWithAnimation(hidden: Bool) {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.isHidden = hidden
        })
    }
}

extension UIView {
func fadeIn(withDuration duration: TimeInterval = 1.0) {
    UIView.animate(withDuration: duration, animations: {
        self.alpha = 1.0
    })
}

/// Fade out a view with a duration
///
/// - Parameter duration: custom animation duration
    func fadeOut(withDuration duration: TimeInterval = 0.75) {
    UIView.animate(withDuration: duration, animations: {
        self.alpha = 0.0
    })
}
}
