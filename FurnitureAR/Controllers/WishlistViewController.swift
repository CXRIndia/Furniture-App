//
//  WishlistViewController.swift
//  FurnitureAR
//
//  Created by akshay patil on 03/11/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import UIKit
import RealmSwift
import AppCenter
import AppCenterCrashes

protocol WishlistViewControllerDelegate: class {
    func diddismissVC(index:Int)
    func diddismissVC()
    func didUpdateWishListItemToCart()
    func didRemoveItem(savedItem:SavedItem)
}


class WishlistViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var fifthButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var numberOfItemLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var savedItemList = Array<SavedItem>()
    let collectionView = UICollectionView(
        frame: CGRect.zero,
        collectionViewLayout: UICollectionViewFlowLayout.init()
    )
    let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    fileprivate var emptyDataView = EmptyDataView()
    fileprivate var borderView = UIView()
    weak var delegate: WishlistViewControllerDelegate?
    var lblBadge = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // For carsh report
        AppCenter.start(withAppSecret: "63cc7968-3c2a-4121-a36e-4ad1e7114762", services:[
          Crashes.self
        ])
                            
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let realm = try! Realm()
        savedItemList = Array(realm.objects(SavedItem.self).filter("itemInCart = false"))
        collectionView.reloadData()
        
        if savedItemList.count > 0 {
            emptyDataView.isHidden = true
            if savedItemList.count > 1 {
                numberOfItemLabel.text = "\(savedItemList.count) Items"
            } else {
                numberOfItemLabel.text = "\(savedItemList.count) Item"
            }
        } else {
            numberOfItemLabel.text = nil
            emptyDataView.isHidden = false
        }
        setupButtonsImageandText()
        
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.delegate?.diddismissVC()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func firstButtonClicked(_ sender: Any) {
        self.delegate?.diddismissVC(index: 0)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func secondButtonClicked(_ sender: Any) {
        self.delegate?.diddismissVC(index: 1)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func thirdButtonClicked(_ sender: Any) {
        self.delegate?.diddismissVC(index: 2)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func fourthButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.diddismissVC(index: 3)
    }
    
    @IBAction func fifthButtonClicked(_ sender: Any) {
    }
    
    
}

extension WishlistViewController {
    func setupUI() {
        setupCollectionView()
        setupEmptyDataView()
        setupButtonsImageandText()
        self.view.bringSubviewToFront(bottomView)
        setupBorderView()
    }
    
    private func setupCollectionView() {
        collectionViewLayout.scrollDirection = .vertical
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.setCollectionViewLayout(
            collectionViewLayout, animated: true
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
        collectionView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 8
        ),
        collectionView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -8
        ),
        collectionView.bottomAnchor.constraint(
            equalTo: bottomView.topAnchor,
            constant: 0
        ),
        collectionView.topAnchor.constraint(equalTo: numberOfItemLabel.bottomAnchor, constant: 38)
        ]
        )
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(WishListCollectionViewCell.self, forCellWithReuseIdentifier:
                   "WishListCollectionViewCell"
        )
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    func setupEmptyDataView() {
        view.addSubview(emptyDataView)
        emptyDataView.translatesAutoresizingMaskIntoConstraints = false
        emptyDataView.configureView(descriptionText: "Uh-oh, looks like your Wishlist is empty.")
        NSLayoutConstraint.activate(
            [
                emptyDataView.topAnchor.constraint(
                    equalTo: numberOfItemLabel.bottomAnchor,
                    constant: 0
                ),
                emptyDataView.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor
                ),
                emptyDataView.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor
                ),
                emptyDataView.bottomAnchor.constraint(
                    equalTo: view.bottomAnchor
                )
            ]
        )
        emptyDataView.isHidden = true
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



extension WishlistViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCollectionViewCell", for: indexPath) as! WishListCollectionViewCell
            cell.delegate = self
            cell.configureView(savedItem: savedItemList[indexPath.item])
            cell.backgroundColor = .white
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let wishListDetailVC = storyboard.instantiateViewController(withIdentifier: "WishListDetailVC") as! WishListDetailVC
        wishListDetailVC.delegate = self
        wishListDetailVC.modalPresentationStyle = .overFullScreen
        wishListDetailVC.savedItem = savedItemList[indexPath.item]
        self.present(wishListDetailVC, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width/2)-5, height: 177)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}


extension WishlistViewController: WishListCollectionViewCellDelegate {
    
    func trashButtonClicked(savedItem: SavedItem) {
        /*
         let realm = try! Realm()
        try! realm.write {
            realm.delete(savedItem)
        }
        */
        self.delegate?.didRemoveItem(savedItem: savedItem)
        let realm = try! Realm()
        savedItemList = Array(realm.objects(SavedItem.self))
        collectionView.reloadData()
        
        if savedItemList.count > 0 {
            emptyDataView.isHidden = true
        } else {
            emptyDataView.isHidden = false
        }
    }
    
    func viewInArButtonClicked(savedItem: SavedItem) {
        
    }
}

extension WishlistViewController {
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

extension WishlistViewController:WishlistViewControllerDelegate {
    func diddismissVC() {
        setBadge()
    }
    
    func didRemoveItem(savedItem: SavedItem) {
        
    }
    
    
    func diddismissVC(index: Int) {
        self.delegate?.diddismissVC(index: index)
    }
    
    func didUpdateWishListItemToCart() {
        let realm = try! Realm()
        savedItemList = Array(realm.objects(SavedItem.self).filter("itemInCart = false"))
        collectionView.reloadData()
        if savedItemList.count > 0 {
            emptyDataView.isHidden = true
            if savedItemList.count > 1 {
                numberOfItemLabel.text = "\(savedItemList.count) Items"
            } else {
                numberOfItemLabel.text = "\(savedItemList.count) Item"
            }
        } else {
            numberOfItemLabel.text = nil
            emptyDataView.isHidden = false
        }
        setBadge()
    }
}


extension WishlistViewController {
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
