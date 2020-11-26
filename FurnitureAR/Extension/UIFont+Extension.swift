//
//  UIFont+Extension.swift
//  eprocessify-ios
//
//  Created by Apple on 05/12/19.
//  Copyright © 2019 CodeToArt Technology Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func regular(_ size: CGFloat) -> UIFont {
        return UIFont(
            name: "Maax", size: size
        )!
    }

    class func medium(_ size: CGFloat) -> UIFont {
        return UIFont(
            name: "Maax-Medium", size: size
        )!
    }

    class func bold(_ size: CGFloat) -> UIFont {
        return UIFont(
            name: "Maax-Bold", size: size
        )!
    }

    
    
}

