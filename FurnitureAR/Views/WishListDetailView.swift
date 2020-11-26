//
//  WishListDetailView.swift
//  FurnitureAR
//
//  Created by akshay patil on 02/11/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import UIKit

protocol WishListDetailViewViewDelegate: class {
    func addtoCartButtonClicked()
    func contactUSButtonClicked()
    func backToWishListButtonClicked()
    func backButtonClicked()
}

class WishListDetailView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var furnitureImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    weak var delegate: WishListDetailViewViewDelegate?
    var dimensionLabel = UILabel()
    var materialLabel = UILabel()
    var styleLabel = UILabel()
    var colorLabel = UILabel()
    var addToCartButton = UIButton()
    var contactUsButton = UIButton()
    var backToWishListButton = UIButton()
    fileprivate var threeLableHorizantalView = ThreeLableHoriantalView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setUpThreeLableHorizantalView()
        setUpAddToCartButton()
        setUpContactUsButton()
        setUpBackToWishListButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configureView(savedItem: SavedItem) {
        
        if let name = savedItem.name {
            nameLabel.text = name
            
        }
        if let image = savedItem.image {
            furnitureImage.image = UIImage(named: image)
            
        }
        if let price = savedItem.price {
            priceLabel.text = price
            
        }
        if let color = savedItem.color {
            colorLabel.text = color
        }
        if let style = savedItem.style {
            styleLabel.text = style
        }
        if let material = savedItem.core_Materials {
            materialLabel.text = material
            
        }
        if let dimension = savedItem.product_Dimensions {
            dimensionLabel.text = dimension
            
        }
        
        if let dimension = savedItem.product_Dimensions,let material = savedItem.core_Materials {
        threeLableHorizantalView.configureView(productDimension: dimension, productMaterial: material, warranty: "6 months")
        }
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("WishListDetailView", owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
            nameLabel.adjustsFontSizeToFitWidth = true
            nameLabel.minimumScaleFactor = 0.2
            nameLabel.numberOfLines = 1
        
            priceLabel.adjustsFontSizeToFitWidth = true
            priceLabel.minimumScaleFactor = 0.2
            priceLabel.numberOfLines = 1
        
            dimensionLabel.adjustsFontSizeToFitWidth = true
            dimensionLabel.minimumScaleFactor = 0.2
            dimensionLabel.numberOfLines = 1
        
        
            materialLabel.adjustsFontSizeToFitWidth = true
            materialLabel.minimumScaleFactor = 0.2
            materialLabel.numberOfLines = 1
        
            styleLabel.adjustsFontSizeToFitWidth = true
            styleLabel.minimumScaleFactor = 0.2
            styleLabel.numberOfLines = 1
        
            colorLabel.adjustsFontSizeToFitWidth = true
            colorLabel.minimumScaleFactor = 0.2
            colorLabel.numberOfLines = 1
        
            
            self.contentView.backgroundColor = .clear
    }
    
    private func setUpThreeLableHorizantalView() {
        
        self.addSubview(threeLableHorizantalView)
        threeLableHorizantalView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                threeLableHorizantalView.leadingAnchor.constraint(
                    equalTo: self.leadingAnchor,
                    constant: 0
                ),
                threeLableHorizantalView.trailingAnchor.constraint(
                    equalTo: self.trailingAnchor,
                    constant: 0
                ),
                threeLableHorizantalView.topAnchor.constraint(
                    equalTo: furnitureImage.bottomAnchor,
                    constant: 13
                )
            ]
        )
    }
    
    private func setUpAddToCartButton() {
        self.addSubview(addToCartButton)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
               
                addToCartButton.leadingAnchor.constraint(
                    equalTo: self.leadingAnchor,
                    constant: 32
                ),
                addToCartButton.trailingAnchor.constraint(
                    equalTo: self.trailingAnchor,
                    constant: -32
                ),
                addToCartButton.heightAnchor.constraint(
                    equalToConstant: 38
                ),
                addToCartButton.topAnchor.constraint(equalTo: threeLableHorizantalView.bottomAnchor, constant: 24)
            ]
        )
        addToCartButton.setTitle("Add to Cart", for: .normal)
        addToCartButton.setTitleColor(UIColor.white, for: .normal)
        addToCartButton.titleLabel?.font = UIFont.medium(14)
        addToCartButton.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        addToCartButton.titleLabel?.textAlignment = .center
        addToCartButton.setCornerRadius(radius: 19)
        addToCartButton.addTarget(self, action: #selector(addToCartButtonClicked), for: .touchUpInside)
    }
    
    private func setUpContactUsButton() {
        self.addSubview(contactUsButton)
        contactUsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
               
                contactUsButton.leadingAnchor.constraint(
                    equalTo: addToCartButton.leadingAnchor,
                    constant: 0
                ),
                contactUsButton.trailingAnchor.constraint(
                    equalTo: addToCartButton.trailingAnchor,
                    constant: 0
                ),
                contactUsButton.heightAnchor.constraint(
                    equalToConstant: 38
                ),
                contactUsButton.topAnchor.constraint(equalTo: addToCartButton.bottomAnchor, constant: 10)
            ]
        )
        contactUsButton.setTitle("Contact Us", for: .normal)
        contactUsButton.setTitleColor(UIColor.white, for: .normal)
        contactUsButton.titleLabel?.font = UIFont.medium(14)
        contactUsButton.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        contactUsButton.titleLabel?.textAlignment = .center
        contactUsButton.setCornerRadius(radius: 19)
        contactUsButton.addTarget(self, action: #selector(contactUSButtonClicked), for: .touchUpInside)
    }
    
    private func setUpBackToWishListButton() {
        self.addSubview(backToWishListButton)
        backToWishListButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
               
                backToWishListButton.leadingAnchor.constraint(
                    equalTo: addToCartButton.leadingAnchor,
                    constant: 0
                ),
                backToWishListButton.trailingAnchor.constraint(
                    equalTo: addToCartButton.trailingAnchor,
                    constant: 0
                ),
                backToWishListButton.heightAnchor.constraint(
                    equalToConstant: 38
                ),
                backToWishListButton.topAnchor.constraint(equalTo: contactUsButton.bottomAnchor, constant: 10),
                backToWishListButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
            ]
        )
        backToWishListButton.setTitle("Back to Wishlist", for: .normal)
        backToWishListButton.setTitleColor(UIColor.white, for: .normal)
        backToWishListButton.titleLabel?.font = UIFont.medium(14)
        backToWishListButton.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        backToWishListButton.titleLabel?.textAlignment = .center
        backToWishListButton.setCornerRadius(radius: 19)
        backToWishListButton.addTarget(self, action: #selector(backToWishListButtonClicked), for: .touchUpInside)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.delegate?.backButtonClicked()
    }
    
    @objc func backToWishListButtonClicked() {
        self.delegate?.backToWishListButtonClicked()
    }
    
    @objc func contactUSButtonClicked() {
        self.delegate?.contactUSButtonClicked()
    }
    
    @objc func addToCartButtonClicked() {
        self.delegate?.addtoCartButtonClicked()
    }
    
}
