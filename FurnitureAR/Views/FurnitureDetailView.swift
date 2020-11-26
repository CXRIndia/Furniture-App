//
//  FurnitureDetailView.swift
//  FurnitureAR
//
//  Created by akshay patil on 18/02/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import UIKit

protocol FurnitureDetailViewDelegate: class {
    func backButtonClickedForFurniture()
    func placeObjectButtonClicked(itemToView: SavedItem)
}

class FurnitureDetailView: UIView {
    weak var delegate: FurnitureDetailViewDelegate?
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var furnitureImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var yellowDotButton: UIButton!
    @IBOutlet weak var blackDotButton: UIButton!
    
    var dimensionLabel = UILabel()
    var materialLabel = UILabel()
    var styleLabel = UILabel()
    var colorLabel = UILabel()
    var placedObjectButton = UIButton()
    fileprivate var threeLableHorizantalView = ThreeLableHoriantalView()
    var itemToView = SavedItem()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setUpThreeLableHorizantalView()
        setUpPlacedObjectButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configureView(for couch: Couches) {
        yellowDotButton.isHidden = true
        blackDotButton.isHidden = true
        itemToView = SavedItem()
        if let name = couch.name {
            nameLabel.text = name
            itemToView.name = name
        }
        if let image = couch.image {
            furnitureImage.image = UIImage(named: image)
            itemToView.image = image
        }
        if let price = couch.price {
            priceLabel.text = price
            itemToView.price = price
        }
        if let color = couch.color {
            colorLabel.text = color
            itemToView.color = color
        }
        if let style = couch.style {
            styleLabel.text = style
            itemToView.style = style
        }
        if let material = couch.core_Materials {
            materialLabel.text = material
            itemToView.core_Materials = material
        }
        if let dimension = couch.product_Dimensions {
            dimensionLabel.text = dimension
            itemToView.product_Dimensions = dimension
        }
        if let id = couch.id {
            itemToView.id = id
        }
        
        if let nodeNameFromDB = couch.daeFileName, let rootNodeNameFromDB = couch.rootNode {
            itemToView.daeFileName = nodeNameFromDB
            itemToView.rootNode = rootNodeNameFromDB
        }
        if let dimension = couch.product_Dimensions,let material = couch.core_Materials {
        threeLableHorizantalView.configureView(productDimension: dimension, productMaterial: material, warranty: "6 months")
        }
    }
    
    func configureView(for chair: Chairs) {
        yellowDotButton.isHidden = true
        blackDotButton.isHidden = true
        itemToView = SavedItem()
        if let name = chair.name {
            nameLabel.text = name
            itemToView.name = name
            if name == "Dining Chair" || name == "Organic Egg-Shaped Swivel Chair" {
                yellowDotButton.isHidden = false
                blackDotButton.isHidden = false
            }
            if name == "Organic Egg-Shaped Swivel Chair" {
                blackDotButton.backgroundColor = .systemPink
                yellowDotButton.backgroundColor = .blue
            } else  {
                blackDotButton.backgroundColor = .init(red: 128/255, green: 90/255, blue: 70/255, alpha: 1)
                yellowDotButton.backgroundColor = .brown
            }
        }
        if let image = chair.image {
            furnitureImage.image = UIImage(named: image)
            itemToView.image = image
        }
        if let price = chair.price {
            priceLabel.text = price
            itemToView.price = price
        }
        if let color = chair.color {
            colorLabel.text = color
            itemToView.color = color
        }
        if let style = chair.style {
            styleLabel.text = style
            itemToView.style = style
        }
        if let material = chair.core_Materials {
            materialLabel.text = material
            itemToView.core_Materials = material
        }
        if let dimension = chair.product_Dimensions {
            dimensionLabel.text = dimension
            itemToView.product_Dimensions = dimension
        }
        if let id = chair.id {
            itemToView.id = id
        }
        
        if let nodeNameFromDB = chair.daeFileName, let rootNodeNameFromDB = chair.rootNode {
            itemToView.daeFileName = nodeNameFromDB
            itemToView.rootNode = rootNodeNameFromDB
        }
        
        if let dimension = chair.product_Dimensions,let material = chair.core_Materials {
        threeLableHorizantalView.configureView(productDimension: dimension, productMaterial: material, warranty: "6 months")
        }
    }
    
    func configureView(for table: Tables) {
        yellowDotButton.isHidden = true
        blackDotButton.isHidden = true
        itemToView = SavedItem()
        if let name = table.name {
            nameLabel.text = name
            itemToView.name = name
        }
        if let image = table.image {
            furnitureImage.image = UIImage(named: image)
            itemToView.image = image
        }
        if let price = table.price {
            priceLabel.text = price
            itemToView.price = price
        }
        if let color = table.color {
            colorLabel.text = color
            itemToView.color = color
        }
        if let style = table.style {
            styleLabel.text = style
            itemToView.style = style
        }
        if let material = table.core_Materials {
            materialLabel.text = material
            itemToView.core_Materials = material
        }
        if let dimension = table.product_Dimensions {
            dimensionLabel.text = dimension
            itemToView.product_Dimensions = dimension
        }
        if let id = table.id {
            itemToView.id = id
        }
        
        if let nodeNameFromDB = table.daeFileName, let rootNodeNameFromDB = table.rootNode {
                   itemToView.daeFileName = nodeNameFromDB
                   itemToView.rootNode = rootNodeNameFromDB
        }
        
        if let dimension = table.product_Dimensions,let material = table.core_Materials {
        threeLableHorizantalView.configureView(productDimension: dimension, productMaterial: material, warranty: "6 months")
        }
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("FurnitureDetailView", owner: self, options: nil)
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
        
            blackDotButton.setCornerRadius(radius: 11.5)
            yellowDotButton.setCornerRadius(radius: 11.5)
            blackDotButton.backgroundColor = .orange
            yellowDotButton.backgroundColor = .blue
            self.contentView.backgroundColor = .clear
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        delegate?.backButtonClickedForFurniture()
    }
    
    @IBAction func blackDotButtonClicked(_ sender: Any) {
        if let name = itemToView.name {
            if name == "Dining Chair" {
                itemToView.daeFileName = "M_127.dae"
                itemToView.rootNode = "M_128"
                furnitureImage.image = UIImage(named: "Dining Chair")
                itemToView.image = "Dining Chair"
            } else {
                itemToView.daeFileName = "M_047.dae"
                itemToView.rootNode = "M_047"
                furnitureImage.image = UIImage(named: "Organic Egg-Shaped Swivel Chair")
                itemToView.image = "Organic Egg-Shaped Swivel Chair"
            }
        }
    }
    
    @IBAction func yellowDotButtonClicked(_ sender: Any) {
        if let name = itemToView.name {
            if name == "Dining Chair" {
                itemToView.daeFileName = "M_127_1.dae"
                itemToView.rootNode = "M_127_1"
                furnitureImage.image = UIImage(named: "Dining Chair_Yellow")
                itemToView.image = "Dining Chair_Yellow"
            } else {
                itemToView.daeFileName = "M_047_1.dae"
                itemToView.rootNode = "M_047_1"
                furnitureImage.image = UIImage(named: "Organic Egg-Shaped Swivel Chair_Blue")
                itemToView.image = "Organic Egg-Shaped Swivel Chair_Blue"
            }
        }
    }
    
    
    @IBAction func PlacedObjectButtonPressed(_ sender: Any) {
        delegate?.placeObjectButtonClicked(itemToView: itemToView)
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
    
    private func setUpPlacedObjectButton() {
        self.addSubview(placedObjectButton)
        placedObjectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
               
                placedObjectButton.leadingAnchor.constraint(
                    equalTo: self.leadingAnchor,
                    constant: 32
                ),
                placedObjectButton.trailingAnchor.constraint(
                    equalTo: self.trailingAnchor,
                    constant: -32
                ),
                placedObjectButton.heightAnchor.constraint(
                    equalToConstant: 36
                ),
                placedObjectButton.topAnchor.constraint(equalTo: threeLableHorizantalView.bottomAnchor, constant: 24)
            ]
        )

        placedObjectButton.addTarget(self, action: #selector(PlacedObjectButtonPressed(_:)), for: .touchUpInside)
        placedObjectButton.setTitle("View in AR mode", for: .normal)
        placedObjectButton.setTitleColor(UIColor.white, for: .normal)
        placedObjectButton.titleLabel?.font = UIFont.medium(12)
        placedObjectButton.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        placedObjectButton.titleLabel?.textAlignment = .center
        placedObjectButton.setCornerRadius(radius: 18)
    }
}
