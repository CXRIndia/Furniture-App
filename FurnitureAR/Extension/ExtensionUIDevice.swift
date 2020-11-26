//
//  ExtensionUIDevice.swift
//  FurnitureAR
//
//  Created by akshay patil on 11/11/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit
public extension UIDevice {

    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    class var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }

    class var isCarPlay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
}

