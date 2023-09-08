//
//  ThreeLableHoriantalView.swift
//  FurnitureAR
//
//  Created by akshay patil on 29/10/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit

class ThreeLableHoriantalView: UIView {
    fileprivate let productDimensionLabel   =  UILabel()
    fileprivate let productMaterialLabel = UILabel()
    fileprivate let warrantyLabel = UILabel()
    fileprivate var horizantalStackView = SeparatorStackView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView(productDimension:String,productMaterial:String, warranty:String) {
        let attrs1 = [NSAttributedString.Key.font : UIFont.medium(10), NSAttributedString.Key.foregroundColor : UIColor.labelTextColor]
        let attrs2 = [NSAttributedString.Key.font : UIFont.regular(12), NSAttributedString.Key.foregroundColor : UIColor.black]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center;
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 3 // Whatever line spacing you want in points
        let blankString = NSMutableAttributedString(string: "\r", attributes:attrs1)
        
        let productDimensionDescriptionString = NSMutableAttributedString(string:"Product Dimension" + "\r", attributes:attrs1)
        let productDimensionString = NSMutableAttributedString(string: productDimension , attributes:attrs2)
        productDimensionDescriptionString.append(productDimensionString)
        productDimensionDescriptionString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, productDimensionDescriptionString.length))
        self.productDimensionLabel.attributedText = productDimensionDescriptionString

        let productMaterialString = NSMutableAttributedString(string:"Product Material" + "\r", attributes:attrs1)
        if Display.typeIsLike == .iphone5 {
            productMaterialString.append(blankString)
        }
        let productMaterialDescriptionString = NSMutableAttributedString(string: productMaterial , attributes:attrs2)
        productMaterialString.append(productMaterialDescriptionString)
        productMaterialString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, productMaterialString.length))
        self.productMaterialLabel.attributedText = productMaterialString

        let warrantyString = NSMutableAttributedString(string:"Warranty" + "\r", attributes:attrs1)
        if Display.typeIsLike == .iphone5 {
            warrantyString.append(blankString)
        }
        let warrantyDescriptionString = NSMutableAttributedString(string:warranty, attributes:attrs2)
        warrantyString.append(warrantyDescriptionString)
        warrantyString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, warrantyString.length))
        self.warrantyLabel.attributedText = warrantyString
       
    }

}

extension ThreeLableHoriantalView {
    func setupUI() {
        setupHorizantalStackView()
        setupLables()
    }

    func setupLables() {
        productDimensionLabel.numberOfLines = 0
        productDimensionLabel.textAlignment = .center

        productMaterialLabel.numberOfLines = 0
        productMaterialLabel.textAlignment = .center

        warrantyLabel.numberOfLines = 0
        warrantyLabel.textAlignment = .center
    }

    func setupHorizantalStackView() {
        horizantalStackView = SeparatorStackView(arrangedSubviews: [productDimensionLabel,productMaterialLabel,warrantyLabel])
        
        self.addSubview(horizantalStackView)
        horizantalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizantalStackView.axis = .horizontal
        horizantalStackView.distribution = .equalSpacing
        horizantalStackView.alignment = .top
        NSLayoutConstraint.activate([
            horizantalStackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 36
            ),
            horizantalStackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -36
            ),
            horizantalStackView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 0
            ),
            horizantalStackView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: 0
            )
        ])
        horizantalStackView.spacing = 5
        horizantalStackView.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        horizantalStackView.isLayoutMarginsRelativeArrangement = true
    }
}
