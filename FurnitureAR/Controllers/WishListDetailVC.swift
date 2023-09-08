//
//  WishListDetailVC.swift
//  FurnitureAR
//
//  Created by akshay patil on 05/11/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class WishListDetailVC: UIViewController {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var fifthButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var firstButton: UIButton!
    let wishListDetailView = WishListDetailView()
    var savedItem = SavedItem()
    weak var delegate: WishlistViewControllerDelegate?
    var lblBadge = UILabel()
    fileprivate var borderView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupButtonsImageandText()
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.delegate?.diddismissVC()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func firstButtonClicked(_ sender: Any) {
        self.delegate?.diddismissVC(index: 0)
        backToWishListButtonClicked()
    }
    @IBAction func secondButtonClicked(_ sender: Any) {
        self.delegate?.diddismissVC(index: 1)
        backToWishListButtonClicked()
    }
    @IBAction func thirdButtonClicked(_ sender: Any) {
        self.delegate?.diddismissVC(index: 2)
        backToWishListButtonClicked()
    }
    @IBAction func fourthButtonClicked(_ sender: Any) {
        backToWishListButtonClicked()
        self.delegate?.diddismissVC(index: 3)
    }
    @IBAction func fifthButtonClicked(_ sender: Any) {
    }
    
}

extension WishListDetailVC {
    func setupUI() {
        setupWishListDetailView()
        setupButtonsImageandText()
        self.view.bringSubviewToFront(bottomView)
        setupBorderView()
    }
    
    func setupWishListDetailView() {
        self.view.addSubview(wishListDetailView)
        wishListDetailView.isHidden = false
        wishListDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wishListDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            wishListDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            wishListDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            wishListDetailView.heightAnchor.constraint(greaterThanOrEqualToConstant: 508)
        ])
        wishListDetailView.backgroundColor = .white
        wishListDetailView.delegate = self
        wishListDetailView.configureView(savedItem: savedItem)
    }
    
    private func setupBorderView() {
        view.addSubview(borderView)
        borderView.backgroundColor = .grayBorderColor
        borderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                    borderView.leadingAnchor.constraint(
                         equalTo: view.leadingAnchor,
                         constant: 20
                         ),
                    borderView.topAnchor.constraint(
                         equalTo: bottomView.topAnchor,
                         constant: 0
                         ),
                    borderView.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -20
                    ),
                    borderView.heightAnchor.constraint(equalToConstant: 1)
             ])
    }
    
    
}

extension WishListDetailVC {
    func setupButtonsImageandText() {
        firstButton.setImage(UIImage(named: "Couches")?.withRenderingMode(.alwaysOriginal), for: .normal)
        firstButton.setTitle("Couches", for: .normal)
        firstButton.setTitleColor(.buttonTextColor, for: .normal)
        firstButton.tintColor = .buttonTextColor
        firstButton.alignImageAndTitleVerticallyForFirstButton()
        
        secondButton.setImage(UIImage(named: "Chairs")?.withRenderingMode(.alwaysOriginal), for: .normal)
        secondButton.setTitle("Chairs", for: .normal)
        secondButton.setTitleColor(.buttonTextColor, for: .normal)
        secondButton.tintColor = .buttonTextColor
        secondButton.alignImageAndTitleVertically()
        
        thirdButton.setImage(UIImage(named: "Tables")?.withRenderingMode(.alwaysOriginal), for: .normal)
        thirdButton.setTitle("Tables", for: .normal)
        thirdButton.setTitleColor(.buttonTextColor, for: .normal)
        thirdButton.tintColor = .buttonTextColor
        thirdButton.alignImageAndTitleVertically()
        
        fourthButton.setImage(UIImage(named: "ShoppingCart")?.withRenderingMode(.alwaysOriginal), for: .normal)
        fourthButton.setTitle("Cart", for: .normal)
        fourthButton.setTitleColor(.buttonTextColor, for: .normal)
        fourthButton.tintColor = .buttonTextColor
        fourthButton.alignImageAndTitleVertically()
        
        fifthButton.setImage(UIImage(named: "Wishlist")?.withRenderingMode(.alwaysOriginal), for: .normal)
        fifthButton.setTitle("Wishlist", for: .normal)
        fifthButton.setTitleColor(.buttonTextColor, for: .normal)
        fifthButton.tintColor = .buttonTextColor
        fifthButton.alignImageAndTitleVertically()
        
        
        fifthButton.setImage(UIImage(named: "WishlistSelected")?.withRenderingMode(.alwaysOriginal), for: .normal)
        fifthButton.setTitle("Wishlist", for: .normal)
        fifthButton.setTitleColor(.buttonTextColor, for: .normal)
        fifthButton.alignImageAndTitleVertically()
        setBadge()
    }
}

extension WishListDetailVC:WishListDetailViewViewDelegate {
    func addtoCartButtonClicked() {
            let itemToView = savedItem
            let realm = try! Realm()
            try! realm.write {
                itemToView.itemCount = 1
                itemToView.itemInCart = true
                realm.add(itemToView, update: .all)
            }
            self.delegate?.didUpdateWishListItemToCart()
            self.dismiss(animated: true, completion: nil)
    }
    
    func contactUSButtonClicked() {
        guard let url = URL(string: "https://cemtrexlabs.com/contact") else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func backToWishListButtonClicked() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func backButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension WishListDetailVC {
    @objc func setBadge() {
        let realm = try! Realm()
        let savedItemList = Array(realm.objects(SavedItem.self).filter("itemInCart = true"))
        if savedItemList.count > 0 {
        lblBadge.frame = CGRect.init(x: fourthButton.frame.width/2, y: 4, width: 24, height: 24)
        lblBadge.backgroundColor = .white
        lblBadge.layer.borderColor = UIColor.buttonTextColor.cgColor
        lblBadge.layer.borderWidth = 1
        lblBadge.setCornerRadius(radius: 12)
        lblBadge.textColor = UIColor.buttonTextColor
        lblBadge.font = .regular(14)
        lblBadge.textAlignment = .center
        lblBadge.isHidden = false
        lblBadge.text = "\(savedItemList.count)"
        lblBadge.removeFromSuperview()
        fourthButton.addSubview(lblBadge)
        } else {
        lblBadge.isHidden = true
        lblBadge.removeFromSuperview()
        }
    }
}
