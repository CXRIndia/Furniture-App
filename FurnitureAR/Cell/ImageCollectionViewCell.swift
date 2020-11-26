//
//  ImageCollectionViewCell.swift

//  Created by Apple on 30/01/20.
//  Copyright © 2020  Technology Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    let furnitureTitleLabel = UILabel()
    let titleImageView = UIImageView()
    let cardShadowView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(imageName:String,furnitureName:String) {
        titleImageView.image = UIImage(named: imageName)
        furnitureTitleLabel.text = furnitureName
    }

    func setupUI() {
        setupCardShadowView()
        setupFurnitureTitleLabel()
        setupTitleImageView()
    }
    
    private func setupCardShadowView() {
        contentView.addSubview(cardShadowView)
        cardShadowView.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate(
            [
                cardShadowView.leadingAnchor.constraint(
                    equalTo: contentView.leadingAnchor,
                    constant: 8
                ),
                cardShadowView.trailingAnchor.constraint(
                    equalTo: contentView.trailingAnchor,
                    constant: -8
                ),
                cardShadowView.topAnchor.constraint(
                    equalTo: contentView.topAnchor,
                    constant: 6
                ),
                cardShadowView.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor,
                    constant: -6
                )
            ])
            cardShadowView.backgroundColor = .collectionViewBackGroundColor
            cardShadowView.addShadowToView(cornerRadius: 10)
    }
    
    func setupFurnitureTitleLabel() {
        cardShadowView.addSubview(furnitureTitleLabel)
        furnitureTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        furnitureTitleLabel.text = "Crystal Chair"
        NSLayoutConstraint.activate([
            
            furnitureTitleLabel.leadingAnchor.constraint(equalTo: cardShadowView.leadingAnchor, constant: 13),
            furnitureTitleLabel.topAnchor.constraint(equalTo: cardShadowView.topAnchor, constant: 12),
            furnitureTitleLabel.trailingAnchor.constraint(equalTo: cardShadowView.trailingAnchor, constant: -13),
            
        ])
        furnitureTitleLabel.textAlignment = .left
        furnitureTitleLabel.adjustsFontSizeToFitWidth = true
        furnitureTitleLabel.minimumScaleFactor = 0.2
        furnitureTitleLabel.numberOfLines = 2
        furnitureTitleLabel.font = .regular(12)
    }

    func setupTitleImageView() {
        cardShadowView.addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.backgroundColor = .clear
        NSLayoutConstraint.activate(
            [
           
            titleImageView.leadingAnchor.constraint(
                equalTo: cardShadowView.leadingAnchor,
                constant: 4
            ),
            titleImageView.trailingAnchor.constraint(
                equalTo: cardShadowView.trailingAnchor,
                constant: -4
            ),
            titleImageView.topAnchor.constraint(
                equalTo: furnitureTitleLabel.bottomAnchor,
                constant: 4
            ),
            titleImageView.bottomAnchor.constraint(
                equalTo: cardShadowView.bottomAnchor,
                constant: -4
            )
         ]
        )
        titleImageView.contentMode = .scaleAspectFit
    }
    
}


