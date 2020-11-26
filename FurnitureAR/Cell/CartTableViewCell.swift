//
//  CartTableViewCell.swift
//  FurnitureAR
//
//  Created by akshay patil on 06/11/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol CartTableViewCellDelegate: class {
    func deleteButtonClicked(index:Int)
    func reloadTableView()
}

class CartTableViewCell: UITableViewCell {
    let furnitureImageView = UIImageView()
    let furnitureTitleLabel = UILabel()
    let furniturePriceLabel = UILabel()
    let cardShadowView = UIView()
    let stepperBackGroundView = UIView()
    let deleteButton = UIButton()
    let addButton = UIButton()
    let removeButton = UIButton()
    let itemQuantityLabel = UILabel()
    weak var delegate: CartTableViewCellDelegate?
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
        if let price = savedItem.price {
            furniturePriceLabel.text = price
        }
        let itemQuantity = savedItem.itemCount
        itemQuantityLabel.text = "\(itemQuantity)"
        
    }

    func setupUI() {
        setupCardShadowView()
        setupDeleteButton()
        setupFurnitureImageView()
        setupFurnitureTitleLabel()
        setupStepperBackGroundView()
        setupAddButton()
        setupRemoveButton()
        setupItemQuantityLabel()
        setupFurniturePriceLabel()
    }
    
    private func setupCardShadowView() {
        contentView.addSubview(cardShadowView)
        cardShadowView.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate(
            [
                cardShadowView.leadingAnchor.constraint(
                    equalTo: contentView.leadingAnchor,
                    constant: 20
                ),
                cardShadowView.trailingAnchor.constraint(
                    equalTo: contentView.trailingAnchor,
                    constant: -20
                ),
                cardShadowView.topAnchor.constraint(
                    equalTo: contentView.topAnchor,
                    constant: 8
                ),
                cardShadowView.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor,
                    constant: -8
                )
            ])
            cardShadowView.backgroundColor = .collectionViewBackGroundColor
            cardShadowView.addShadowToView(cornerRadius: 10)
    }
    
    func setupDeleteButton() {
        cardShadowView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: cardShadowView.topAnchor, constant: 6),
            deleteButton.trailingAnchor.constraint(equalTo: cardShadowView.trailingAnchor, constant: -8),
            deleteButton.heightAnchor.constraint(equalToConstant: 20),
            deleteButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        deleteButton.setImage(UIImage(named: "CrossButton"), for: .normal)
        deleteButton.imageView?.contentMode = .scaleAspectFit
        deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
    }
    
    
    func setupFurnitureImageView() {
        cardShadowView.addSubview(furnitureImageView)
        furnitureImageView.image = UIImage(named: "Couch")
        furnitureImageView.contentMode = .scaleAspectFill
        furnitureImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            furnitureImageView.heightAnchor.constraint(equalToConstant: 88),
            furnitureImageView.widthAnchor.constraint(equalToConstant: 59),
            furnitureImageView.centerYAnchor.constraint(equalTo: cardShadowView.centerYAnchor, constant: 0),
            furnitureImageView.leadingAnchor.constraint(equalTo: cardShadowView.leadingAnchor, constant: 29)
        ])
    }
    
    func setupFurnitureTitleLabel() {
        cardShadowView.addSubview(furnitureTitleLabel)
        furnitureTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        furnitureTitleLabel.text = "Crystal Chair"
        NSLayoutConstraint.activate([
            furnitureTitleLabel.leadingAnchor.constraint(equalTo: furnitureImageView.trailingAnchor, constant: 50),
            furnitureTitleLabel.topAnchor.constraint(equalTo: cardShadowView.topAnchor, constant: 20),
            furnitureTitleLabel.trailingAnchor.constraint(equalTo: cardShadowView.trailingAnchor, constant: -8),
        ])
        furnitureTitleLabel.textAlignment = .left
        furnitureTitleLabel.adjustsFontSizeToFitWidth = true
        furnitureTitleLabel.minimumScaleFactor = 0.2
        furnitureTitleLabel.numberOfLines = 1
        furnitureTitleLabel.font = .medium(18)
        furnitureTitleLabel.textColor = .labelTextColor
    }
    
    private func setupStepperBackGroundView() {
        cardShadowView.addSubview(stepperBackGroundView)
        stepperBackGroundView.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate(
            [
                stepperBackGroundView.leadingAnchor.constraint(
                    equalTo: furnitureTitleLabel.leadingAnchor,
                    constant: 0
                ),
                stepperBackGroundView.topAnchor.constraint(
                    equalTo: furnitureTitleLabel.bottomAnchor,
                    constant: 12
                ),
                stepperBackGroundView.heightAnchor.constraint(equalToConstant: 30),
                stepperBackGroundView.widthAnchor.constraint(equalToConstant: 88),
            ])
        stepperBackGroundView.backgroundColor = .white
        stepperBackGroundView.addShadowToView(cornerRadius: 16)
    }
    
    func setupAddButton() {
        stepperBackGroundView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: stepperBackGroundView.centerYAnchor, constant: 0),
            addButton.leadingAnchor.constraint(equalTo: stepperBackGroundView.leadingAnchor, constant: 4),
            addButton.heightAnchor.constraint(equalToConstant: 20),
            addButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        addButton.setImage(UIImage(named: "PlusIcon"), for: .normal)
        addButton.imageView?.contentMode = .center
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    
    
    func setupRemoveButton() {
        stepperBackGroundView.addSubview(removeButton)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            removeButton.centerYAnchor.constraint(equalTo: stepperBackGroundView.centerYAnchor, constant: 0),
            removeButton.trailingAnchor.constraint(equalTo: stepperBackGroundView.trailingAnchor, constant: -4),
            removeButton.heightAnchor.constraint(equalToConstant: 20),
            removeButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        removeButton.setImage(UIImage(named: "MinusIcon"), for: .normal)
        removeButton.imageView?.contentMode = .center
        removeButton.addTarget(self, action: #selector(removeButtonClicked), for: .touchUpInside)
    }
    
    func setupItemQuantityLabel() {
        stepperBackGroundView.addSubview(itemQuantityLabel)
        itemQuantityLabel.translatesAutoresizingMaskIntoConstraints = false
        itemQuantityLabel.text = "2"
        NSLayoutConstraint.activate([
            itemQuantityLabel.centerYAnchor.constraint(equalTo: stepperBackGroundView.centerYAnchor, constant: 0),
            itemQuantityLabel.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 0),
            itemQuantityLabel.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor, constant: 0),
        ])
        itemQuantityLabel.textAlignment = .center
        itemQuantityLabel.adjustsFontSizeToFitWidth = true
        itemQuantityLabel.minimumScaleFactor = 0.2
        itemQuantityLabel.numberOfLines = 1
        itemQuantityLabel.font = .regular(16)
        itemQuantityLabel.textColor = .black
    }
    
    func setupFurniturePriceLabel() {
        cardShadowView.addSubview(furniturePriceLabel)
        furniturePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        furniturePriceLabel.text = "$ 17.99"
        NSLayoutConstraint.activate([
            furniturePriceLabel.topAnchor.constraint(equalTo: stepperBackGroundView.bottomAnchor, constant: 12),
            furniturePriceLabel.leadingAnchor.constraint(equalTo: furnitureTitleLabel.leadingAnchor, constant: 0),
            furniturePriceLabel.trailingAnchor.constraint(equalTo: furnitureTitleLabel.trailingAnchor, constant: 0),
            furniturePriceLabel.bottomAnchor.constraint(equalTo: cardShadowView.bottomAnchor, constant: -12),
            

        ])
        furniturePriceLabel.textAlignment = .left
        furniturePriceLabel.adjustsFontSizeToFitWidth = true
        furniturePriceLabel.minimumScaleFactor = 0.2
        furniturePriceLabel.numberOfLines = 1
        furniturePriceLabel.font = .medium(17)
        furnitureTitleLabel.textColor = .black
    }
    
}

extension CartTableViewCell {
    @objc func deleteButtonClicked() {
        self.delegate?.deleteButtonClicked(index: self.tag)
    }
    
    @objc func addButtonClicked() {
        let itemToView = savedItem
        let realm = try! Realm()
        try! realm.write {
            itemToView.itemCount += 1
            realm.add(itemToView, update: .all)
        }
        self.delegate?.reloadTableView()
    }
    
    @objc func removeButtonClicked() {
        let itemToView = savedItem
        if savedItem.itemCount > 1 {
            let realm = try! Realm()
            try! realm.write {
                itemToView.itemCount -= 1
                realm.add(itemToView, update: .all)
            }
        }
        self.delegate?.reloadTableView()
    }
}
