//
//  WishListTableViewCell.swift
//  FurnitureAR
//
//  Created by akshay patil on 18/02/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit


class WishListTableViewCell: UITableViewCell {
    let furnitureImageView = UIImageView()
    let furnitureTitleLabel = UILabel()
    let furnitureDimensionLabel = UILabel()
    let furnitureTypeLabel = UILabel()
    let furniturePriceLabel = UILabel()
    let buyNowButton = UIButton()
    let viewInArButton = UIButton()
    let trashButton = UIButton()
    var savedItem = SavedItem()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.tintColor = .clear
        self.contentView.backgroundColor = .clear
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(savedItem: SavedItem) {
        self.savedItem = savedItem
        if let name = savedItem.name {
            furnitureTitleLabel.text = name
        }
        if let image = savedItem.image {
            furnitureImageView.image = UIImage(named: image)
        }
        if let dimension = savedItem.product_Dimensions {
            furnitureDimensionLabel.text = dimension
        }
        if let type = savedItem.core_Materials {
            furnitureTypeLabel.text = type
        }
        if let price = savedItem.price {
            furniturePriceLabel.text = price
        }
    }

    func setupUI() {
        setupFurnitureImageView()
        setupFurnitureTitleLabel()
        setupTrashButton()
        setupFurnitureDimensionLabel()
        setupFurnitureTypeLabel()
        setupFurniturePriceLabel()
        setupBuyNowButton()
        setupViewInArButton()
    }
    
    
    func setupFurnitureImageView() {
        contentView.addSubview(furnitureImageView)
        furnitureImageView.image = UIImage(named: "Couch")
        furnitureImageView.contentMode = .scaleAspectFill
        furnitureImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            furnitureImageView.heightAnchor.constraint(equalToConstant: 121),
            furnitureImageView.widthAnchor.constraint(equalToConstant: 121),
            furnitureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            furnitureImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            furnitureImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25.5)
        ])
    }
    
    func setupFurnitureTitleLabel() {
        contentView.addSubview(furnitureTitleLabel)
        furnitureTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        furnitureTitleLabel.text = "Crystal Chair"
        NSLayoutConstraint.activate([
            
            furnitureTitleLabel.leadingAnchor.constraint(equalTo: furnitureImageView.trailingAnchor, constant: 13),
            furnitureTitleLabel.topAnchor.constraint(equalTo: furnitureImageView.topAnchor, constant: 6),
            
        ])
        furnitureTitleLabel.textAlignment = .left
        furnitureTitleLabel.adjustsFontSizeToFitWidth = true
        furnitureTitleLabel.minimumScaleFactor = 0.2
        furnitureTitleLabel.numberOfLines = 1
        furnitureTitleLabel.font = .regular(17)
    }
    
    func setupTrashButton() {
        contentView.addSubview(trashButton)
        trashButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trashButton.centerYAnchor.constraint(equalTo: furnitureTitleLabel.centerYAnchor, constant: 6),
            trashButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            trashButton.leadingAnchor.constraint(equalTo: furnitureTitleLabel.trailingAnchor, constant: 4),
            trashButton.heightAnchor.constraint(equalToConstant: 18),
            trashButton.widthAnchor.constraint(equalToConstant: 16)
        ])
        trashButton.addTarget(self, action: #selector(trashButtonClicked), for: .touchUpInside)
        trashButton.setImage(UIImage(named: "trash"), for: .normal)
        trashButton.imageView?.contentMode = .scaleAspectFit
    }
    
    func setupFurnitureDimensionLabel() {
        contentView.addSubview(furnitureDimensionLabel)
        furnitureDimensionLabel.translatesAutoresizingMaskIntoConstraints = false
        furnitureDimensionLabel.text = "24 In X 24 In X 31 In"
        NSLayoutConstraint.activate([
            
            furnitureDimensionLabel.leadingAnchor.constraint(equalTo: furnitureTitleLabel.leadingAnchor, constant: 0),
            furnitureDimensionLabel.topAnchor.constraint(equalTo: furnitureTitleLabel.bottomAnchor, constant: 5),
            furnitureDimensionLabel.trailingAnchor.constraint(equalTo: trashButton.trailingAnchor, constant: 0),
            
        ])
        furnitureDimensionLabel.textAlignment = .left
        furnitureDimensionLabel.adjustsFontSizeToFitWidth = true
        furnitureDimensionLabel.minimumScaleFactor = 0.2
        furnitureDimensionLabel.numberOfLines = 1
        furnitureDimensionLabel.font = .regular(11)
    }
    
    func setupFurnitureTypeLabel() {
        contentView.addSubview(furnitureTypeLabel)
        furnitureTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        furnitureTypeLabel.text = "Polypropylene"
        NSLayoutConstraint.activate([
            
            furnitureTypeLabel.leadingAnchor.constraint(equalTo: furnitureTitleLabel.leadingAnchor, constant: 0),
            furnitureTypeLabel.topAnchor.constraint(equalTo: furnitureDimensionLabel.bottomAnchor, constant: 0),
            furnitureTypeLabel.trailingAnchor.constraint(equalTo: trashButton.trailingAnchor, constant: 0),
            
        ])
        furnitureTypeLabel.textAlignment = .left
        furnitureTypeLabel.adjustsFontSizeToFitWidth = true
        furnitureTypeLabel.minimumScaleFactor = 0.2
        furnitureTypeLabel.numberOfLines = 1
        furnitureTypeLabel.font = .regular(11)
    }
    
    func setupFurniturePriceLabel() {
        contentView.addSubview(furniturePriceLabel)
        furniturePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        furniturePriceLabel.text = "$ 17.99"
        NSLayoutConstraint.activate([
            
            furniturePriceLabel.leadingAnchor.constraint(equalTo: furnitureTitleLabel.leadingAnchor, constant: 0),
            furniturePriceLabel.topAnchor.constraint(equalTo: furnitureTypeLabel.bottomAnchor, constant: 3),
            furniturePriceLabel.trailingAnchor.constraint(equalTo: trashButton.trailingAnchor, constant: 0),

        ])
        furniturePriceLabel.textAlignment = .left
        furniturePriceLabel.adjustsFontSizeToFitWidth = true
        furniturePriceLabel.minimumScaleFactor = 0.2
        furniturePriceLabel.numberOfLines = 1
        furniturePriceLabel.font = .regular(11)
    }
    
    func setupBuyNowButton() {
        contentView.addSubview(buyNowButton)
        buyNowButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            buyNowButton.leadingAnchor.constraint(equalTo: furnitureTitleLabel.leadingAnchor, constant: 0),
            buyNowButton.topAnchor.constraint(equalTo: furniturePriceLabel.bottomAnchor, constant: 15),
            buyNowButton.heightAnchor.constraint(equalToConstant: 23),
            buyNowButton.widthAnchor.constraint(equalToConstant: 83)
        ])
        buyNowButton.layer.cornerRadius = 12
        buyNowButton.backgroundColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1)
        buyNowButton.setTitleColor(.white, for: .normal)
        buyNowButton.setTitle("Buy Now", for: .normal)
        buyNowButton.titleLabel?.font = .regular(10)
    }
    
    func setupViewInArButton() {
        contentView.addSubview(viewInArButton)
        viewInArButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewInArButton.leadingAnchor.constraint(equalTo: buyNowButton.trailingAnchor, constant: 10),
            viewInArButton.topAnchor.constraint(equalTo: furniturePriceLabel.bottomAnchor, constant: 15),
            viewInArButton.heightAnchor.constraint(equalToConstant: 23),
            viewInArButton.widthAnchor.constraint(equalToConstant: 83)
        ])
        viewInArButton.layer.cornerRadius = 12
        viewInArButton.backgroundColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1)
        viewInArButton.setTitleColor(.white, for: .normal)
        viewInArButton.addTarget(self, action: #selector(viewInArButtonClicked), for: .touchUpInside)
        viewInArButton.titleLabel?.font = .regular(10)
        viewInArButton.getHorizontalContent(titleText: "View In Ar", imageString: "ViewInARButtonImage")
        
    }
    
}

extension WishListTableViewCell {
    @objc func trashButtonClicked() {
        // delegate?.trashButtonClicked(savedItem: savedItem)
    }
    @objc func viewInArButtonClicked() {
        // delegate?.viewInArButtonClicked(savedItem: savedItem)
    }
}
