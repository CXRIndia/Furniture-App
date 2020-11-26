//
//  SeparatorStackView.swift
//  FurnitureAR
//
//  Created by akshay patil on 29/10/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class SeparatorStackView: UIStackView {

    @IBInspectable var separatorColor: UIColor? = .labelTextColor {
        didSet {
            invalidateSeparators()
        }
    }
    @IBInspectable var separatorWidth: CGFloat = 0.5 {
        didSet {
            invalidateSeparators()
        }
    }
    @IBInspectable private var separatorTopPadding: CGFloat = 0 {
        didSet {
            separatorInsets.top = separatorTopPadding
        }
    }
    @IBInspectable private var separatorBottomPadding: CGFloat = 0 {
        didSet {
            separatorInsets.bottom = separatorBottomPadding
        }
    }
    @IBInspectable private var separatorLeftPadding: CGFloat = 0 {
        didSet {
            separatorInsets.left = separatorLeftPadding
        }
    }
    @IBInspectable private var separatorRightPadding: CGFloat = 0 {
        didSet {
            separatorInsets.right = separatorRightPadding
        }
    }

    var separatorInsets: UIEdgeInsets = .zero {
        didSet {
            invalidateSeparators()
        }
    }

    private var separators: [UIView] = []

    override func layoutSubviews() {
        super.layoutSubviews()

        invalidateSeparators()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        invalidateSeparators()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        invalidateSeparators()
    }


    private func invalidateSeparators() {
        guard arrangedSubviews.count > 1 else {
          separators.forEach({$0.removeFromSuperview()})
          separators.removeAll()
          return
        }

        if separators.count > arrangedSubviews.count {
          separators.removeLast(separators.count - arrangedSubviews.count)
        } else if separators.count < arrangedSubviews.count {
          for _ in 0..<(arrangedSubviews.count - separators.count - 1) {
            separators.append(UIView())
          }
        }

        separators.forEach({$0.backgroundColor = self.separatorColor; self.addSubview($0)})

        for (index, subview) in arrangedSubviews.enumerated() where arrangedSubviews.count >= index + 2 {
          let nextSubview = arrangedSubviews[index + 1]
          let separator = separators[index]

          let origin: CGPoint
          let size: CGSize

          if axis == .horizontal {
            let originX = subview.frame.maxX + (nextSubview.frame.minX - subview.frame.maxX) / 2.0 + separatorInsets.left - separatorInsets.right
            origin = CGPoint(x: originX, y: separatorInsets.top)
            let height = frame.height - separatorInsets.bottom - separatorInsets.top
            size = CGSize(width: separatorWidth, height: height)
          } else {
            let originY = subview.frame.maxY + (nextSubview.frame.minY - subview.frame.maxY) / 2.0 + separatorInsets.top - separatorInsets.bottom
            origin = CGPoint(x: separatorInsets.left, y: originY)
            let width = frame.width - separatorInsets.left - separatorInsets.right
            size = CGSize(width: width, height: separatorWidth)
          }

          separator.frame = CGRect(origin: origin, size: size)
          separator.isHidden = nextSubview.isHidden
        }
      }
}
