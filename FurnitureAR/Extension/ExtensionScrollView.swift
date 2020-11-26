//
//  ExtensionScrollView.swift
//  FurnitureAR
//
//  Created by akshay patil on 20/02/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit
extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: false)
   }
}
