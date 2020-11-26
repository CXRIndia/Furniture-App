//
//  CartViewController.swift
//  FurnitureAR
//
//  Created by akshay patil on 06/11/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class CartViewController: UIViewController {

    @IBOutlet weak var totalItemLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var fifthButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var checkOutButton: UIButton!
    fileprivate var emptyDataView = EmptyDataView()
    fileprivate var borderView = UIView()
    weak var delegate: WishlistViewControllerDelegate?
    let tableView = UITableView()
    var savedItemList = Array<SavedItem>()
    var lblBadge = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let realm = try! Realm()
        savedItemList = Array(realm.objects(SavedItem.self).filter("itemInCart = true"))
        tableView.reloadData()
        
        if savedItemList.count > 0 {
            emptyDataView.isHidden = true
        } else {
            emptyDataView.isHidden = false
        }
        setupItemPrice()
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
        
    }
    
    @IBAction func fifthButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.diddismissVC(index: 4)
    }
    @IBAction func checkOutButtonClicked(_ sender: Any) {
        if let url = URL(string: "https://cemtrexlabs.com/") {
            UIApplication.shared.open(url)
        }
    }
    
    
}

extension CartViewController {
    func setupUI() {
        setupCheckOutButton()
        setupTableView()
        setupEmptyDataView()
        setupButtonsImageandText()
        self.view.bringSubviewToFront(bottomView)
        setupBorderView()
    }
    
    private func setupTableView() {
            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.estimatedRowHeight = 200
            tableView.rowHeight = UITableView.automaticDimension
            tableView.backgroundColor = .clear
            tableView.showsVerticalScrollIndicator = false
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            NSLayoutConstraint.activate(
                [
                    tableView.topAnchor.constraint(
                        equalTo: titleLabel.bottomAnchor,
                        constant: 20
                    ),
                    tableView.leadingAnchor.constraint(
                        equalTo: view.leadingAnchor
                    ),
                    tableView.trailingAnchor.constraint(
                        equalTo: view.trailingAnchor
                    ),
                    tableView.bottomAnchor.constraint(
                        equalTo: bottomLineView.topAnchor
                    ),
                ]
            )
            self.tableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 88,right: 0)
            tableView.register(
                CartTableViewCell.self,
                forCellReuseIdentifier: "CartTableViewCell"
            )
            tableView.backgroundColor = .white
    }
    
    func setupEmptyDataView() {
        view.addSubview(emptyDataView)
        emptyDataView.translatesAutoresizingMaskIntoConstraints = false
        emptyDataView.configureView(descriptionText: "Uh-oh, looks like your Cart is empty.")
        NSLayoutConstraint.activate(
            [
                emptyDataView.topAnchor.constraint(
                    equalTo: titleLabel.bottomAnchor,
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
    
    func setupCheckOutButton() {
        checkOutButton.setCornerRadius(radius: 18)
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

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedItemList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        cell.configureView(savedItem: savedItemList[indexPath.row])
        cell.tag = indexPath.row
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}

extension CartViewController {
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
        
        
        fourthButton.setImage(UIImage(named: "ShoppingCartSelected")?.withRenderingMode(.alwaysOriginal), for: .normal)
        fourthButton.setTitle("Cart", for: .normal)
        fourthButton.setTitleColor(.buttonTextColor, for: .normal)
        fourthButton.alignImageAndTitleVertically()
        setBadge()
    }
}

extension CartViewController:CartTableViewCellDelegate {
    func deleteButtonClicked(index: Int) {
        let removefromCartVC = RemovefromCartVC()
        removefromCartVC.delegate = self
        removefromCartVC.savedItem = savedItemList[index]
        removefromCartVC.providesPresentationContextTransitionStyle = true
        removefromCartVC.definesPresentationContext = true
        removefromCartVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        removefromCartVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        self.present(removefromCartVC, animated: true, completion: nil)
    }
    
    func reloadTableView() {
        tableView.reloadData()
        setupItemPrice()
    }
}

extension CartViewController:RemovefromCartVCDelegate {
    func didRemoveItemFromCart(savedItem:SavedItem) {
        self.delegate?.didRemoveItem(savedItem: savedItem)
        let realm = try! Realm()
        savedItemList = Array(realm.objects(SavedItem.self).filter("itemInCart = true"))
        tableView.reloadData()
        
        if savedItemList.count > 0 {
            emptyDataView.isHidden = true
        } else {
            emptyDataView.isHidden = false
        }
        setBadge()
    }
}

extension CartViewController {
    func setupItemPrice() {
        var total = 0
        for item in savedItemList {
          if var price = item.price {
            price.remove(at: price.startIndex)
            price = price.filter { $0 != "," }
            if let priceInInt = Int(price) {
                total += priceInInt * item.itemCount
            }
          }
        }
        totalPriceLabel.text = "$ \(total)"
        if savedItemList.count > 1 {
            totalItemLabel.text = "\(savedItemList.count) Items"
        } else {
            totalItemLabel.text = "\(savedItemList.count) Item"
        }
    }
}

extension CartViewController {
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
