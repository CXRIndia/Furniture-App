//
//  extensionfloat4x4.swift
//  FurnitureAR
//
//  Created by akshay patil on 14/02/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
extension float4x4 {
    var translation: SIMD3<Float> {
        let translation = self.columns.3
        return SIMD3<Float>(translation.x, translation.y, translation.z)
    }
}
