//
//  extensionSCNNode.swift
//  FurnitureAR
//
//  Created by akshay patil on 14/02/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import SceneKit


fileprivate let highlightMaskValue: Int = 2
fileprivate let normalMaskValue: Int = 1

extension SCNNode {
    convenience init(named name: String) {
        self.init()
        guard let scene = SCNScene(named: name) else {
            return
        }

        for childNode in scene.rootNode.childNodes {
            addChildNode(childNode)
        }
    }
}

extension SCNNode {
    func setHighlighted( _ highlighted : Bool = true, _ highlightedBitMask : Int = 2 ) {
       
        if highlighted {
        self.setCategoryBitMaskForAllHierarchy(highlightMaskValue)
        } else {
        self.setCategoryBitMaskForAllHierarchy(normalMaskValue)
        }
        
        /*
        categoryBitMask = highlightedBitMask
        for child in self.childNodes {
            child.setHighlighted()
        }
        */
    }
}
