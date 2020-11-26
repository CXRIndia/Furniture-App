//
//  extensionUIButton.swift
//  FurnitureAR
//
//  Created by akshay patil on 14/02/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit
extension UIButton {

    func getHorizontalContent(titleText: String?, imageString: String?) {
        let insetAmount:CGFloat = 16
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: insetAmount)
        
        if let text = titleText {
            self.setTitle(text, for: .normal)
        }
        
        if let imageString = imageString {
            self.setImage(UIImage(named: imageString), for: .normal)
        }
        self.titleLabel?.textAlignment = .left
        self.titleLabel?.numberOfLines = 0
        self.setTitleColor(UIColor.white, for: .normal)
        self.contentHorizontalAlignment = .left
    }
    
    func alignImageAndTitleVertically(padding: CGFloat = 6.0) {
        let imageSize = self.imageView!.frame.size
        let titleSize = self.titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + padding

        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )

        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize.width,
            bottom: -(40),
            right: 0
        )
    }
    
    func alignImageAndTitleVerticallyForFirstButton(padding: CGFloat = 6.0) {
        let imageSize = self.imageView!.frame.size
        let titleSize = self.titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + padding

        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )

        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -(imageSize.width),
            bottom: -(40),
            right: 0
        )
    }
}
