//
//  AddDeleteFurnitureView.swift
//  FurnitureAR
//
//  Created by akshay patil on 21/02/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

public protocol AddDeleteFurnitureViewDelegate: class {
    func addToWishListButtonClicked()
    func deleteButtonClicked()
    func shutterButtonClicked()
    func saveButtonClicked()
    func shareButtonClicked()
}

class AddDeleteFurnitureView: UIView {
    weak var delegate: AddDeleteFurnitureViewDelegate?
    @IBOutlet weak var backgroundViewForShare: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var addToWishlistButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var wishListLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configureView(savedItem: SavedItem) {
        let realm = try! Realm()
        if let _ = realm.objects(SavedItem.self).filter("id == %@",savedItem.id!).first {
            wishListLabel.text = "Wishlisted"
            addToWishlistButton.setImage(UIImage(named: "heartSelected"), for: .normal)
        } else {
            wishListLabel.text = "Wishlist"
            addToWishlistButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        self.backgroundViewForShare.isHidden = true
    }
    
    func setAddToWishListImage() {
        wishListLabel.text = "Wishlist"
        addToWishlistButton.setImage(UIImage(named: "heart"), for: .normal)
        self.backgroundViewForShare.isHidden = true
    }
    
    
    
    private func commonInit() {
        Bundle.main.loadNibNamed("AddDeleteFurnitureView", owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.contentView.backgroundColor = .white
            self.backgroundViewForShare.isHidden = true
    }
    
    @IBAction func addToWishListButtonClicked(_ sender: Any) {
        delegate?.addToWishListButtonClicked()
    }
    @IBAction func deleteButtonClicked(_ sender: Any) {
        delegate?.deleteButtonClicked()
    }
    @IBAction func shutterButtonClicked(_ sender: Any) {
        delegate?.shutterButtonClicked()
        self.backgroundViewForShare.isHidden = false
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        self.delegate?.saveButtonClicked()
        self.backgroundViewForShare.isHidden = true
    }
    @IBAction func saveAndShareButtonClicked(_ sender: Any) {
        self.delegate?.shareButtonClicked()
        self.backgroundViewForShare.isHidden = true
    }
    
}
