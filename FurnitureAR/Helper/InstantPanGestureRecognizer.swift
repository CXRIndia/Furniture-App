//
//  InstantPanGestureRecognizer.swift
//  FurnitureAR
//
//  Created by akshay patil on 14/02/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit

// MARK: - InstantPanGestureRecognizer

/// A pan gesture that enters into the `began` state on touch down instead of waiting for a touches moved event.
class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }
    
}
