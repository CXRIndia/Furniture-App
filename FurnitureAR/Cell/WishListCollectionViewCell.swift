//
//  WishListCollectionViewCell.swift
//  FurnitureAR
//
//  Created by akshay patil on 02/11/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit

protocol WishListCollectionViewCellDelegate: class {
    func trashButtonClicked(savedItem:SavedItem)
    func viewInArButtonClicked(savedItem:SavedItem)
}


class WishListCollectionViewCell: UICollectionViewCell {
    weak var delegate: WishListCollectionViewCellDelegate?
    let furnitureTitleLabel = UILabel()
    let titleImageView = UIImageView()
    let cardShadowView = UIView()
    let borderView = UIView()
    let furniturePriceLabel = UILabel()
    let deleteButton = UIButton()
    var savedItem = SavedItem()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(savedItem: SavedItem) {
        self.savedItem = savedItem
        if let name = savedItem.name {
            furnitureTitleLabel.text = name
        }
        if let image = savedItem.image {
            titleImageView.image = UIImage(named: image)
        }
        
        if let price = savedItem.price {
            furniturePriceLabel.text = price
        }
    }

    func setupUI() {
        setupCardShadowView()
        setupDeleteButton()
        setupTitleImageView()
        setupBorderView()
        setupFurnitureTitleLabel()
        setupFurniturePriceLabel()
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
    
    func setupDeleteButton() {
          cardShadowView.addSubview(deleteButton)
          deleteButton.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              deleteButton.trailingAnchor.constraint(
                  equalTo: cardShadowView.trailingAnchor,
                  constant: -12
              ),
              deleteButton.topAnchor.constraint(
                equalTo: self.cardShadowView.topAnchor, constant: 12
              ),
              deleteButton.heightAnchor.constraint(equalToConstant: 12),
              deleteButton.widthAnchor.constraint(equalToConstant: 12)
           ])
        deleteButton.setImage(UIImage(named: "Cancel"), for: .normal)
        deleteButton.backgroundColor = .clear
        deleteButton.addTarget(self, action: #selector(trashButtonClicked), for: .touchUpInside)
    }
    
    func setupTitleImageView() {
        cardShadowView.addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.backgroundColor = .clear
        NSLayoutConstraint.activate(
            [
           
            titleImageView.topAnchor.constraint(
                equalTo: deleteButton.centerYAnchor,
                constant: 0
            ),
            titleImageView.trailingAnchor.constraint(
                equalTo: cardShadowView.trailingAnchor,
                constant: -4
            ),
            titleImageView.leadingAnchor.constraint(
                equalTo: cardShadowView.leadingAnchor,
                constant: 4
            ),
            titleImageView.heightAnchor.constraint(equalToConstant: 72)
         ]
        )
        titleImageView.image = UIImage(named: "Dining Room Chair")
        titleImageView.contentMode = .scaleAspectFit
    }
    
    func setupBorderView() {
        cardShadowView.addSubview(borderView)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = .borderColor
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: cardShadowView.leadingAnchor, constant: 12),
            borderView.trailingAnchor.constraint(equalTo: cardShadowView.trailingAnchor, constant: -12),
            borderView.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 16),
            borderView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupFurnitureTitleLabel() {
        cardShadowView.addSubview(furnitureTitleLabel)
        furnitureTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        furnitureTitleLabel.text = "Crystal Chair"
        NSLayoutConstraint.activate([
            
            furnitureTitleLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 0),
            furnitureTitleLabel.topAnchor.constraint(equalTo: borderView.bottomAnchor, constant: 12),
            furnitureTitleLabel.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: 0),
            
        ])
        furnitureTitleLabel.textAlignment = .left
        furnitureTitleLabel.adjustsFontSizeToFitWidth = true
        furnitureTitleLabel.minimumScaleFactor = 0.2
        furnitureTitleLabel.numberOfLines = 2
        furnitureTitleLabel.font = .medium(13)
        furnitureTitleLabel.textColor = .labelTextColor
    }
    
    func setupFurniturePriceLabel() {
        cardShadowView.addSubview(furniturePriceLabel)
        furniturePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        furniturePriceLabel.text = "Price"
        NSLayoutConstraint.activate([
            
            furniturePriceLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 0),
            furniturePriceLabel.topAnchor.constraint(equalTo: furnitureTitleLabel.bottomAnchor, constant: 2),
            furniturePriceLabel.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: 0),
            furniturePriceLabel.bottomAnchor.constraint(equalTo: cardShadowView.bottomAnchor, constant: -12),
            
        ])
        furniturePriceLabel.textAlignment = .left
        furniturePriceLabel.adjustsFontSizeToFitWidth = true
        furniturePriceLabel.minimumScaleFactor = 0.2
        furniturePriceLabel.numberOfLines = 2
        furniturePriceLabel.font = .regular(13)
        furniturePriceLabel.textColor = .black
    }
    
}


extension WishListCollectionViewCell {
    @objc func trashButtonClicked() {
        delegate?.trashButtonClicked(savedItem: savedItem)
    }
    @objc func viewInArButtonClicked() {
        delegate?.viewInArButtonClicked(savedItem: savedItem)
    }
}
