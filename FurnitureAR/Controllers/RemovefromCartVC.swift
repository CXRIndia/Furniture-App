//
//  RemovefromCartVC.swift
//  FurnitureAR
//
//  Created by akshay patil on 06/11/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import AppCenter
import AppCenterCrashes

protocol RemovefromCartVCDelegate: class {
    func didRemoveItemFromCart(savedItem:SavedItem)
}

class RemovefromCartVC: UIViewController {
    
    var viewForAlert = UIView()
    var yesButton = UIButton()
    var noButton = UIButton()
    var titleLabel = UILabel()
    var savedItem = SavedItem()
    var delegate: RemovefromCartVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        // For carsh report
        AppCenter.start(withAppSecret: "63cc7968-3c2a-4121-a36e-4ad1e7114762", services:[
          Crashes.self
        ])
                            
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
}

extension RemovefromCartVC {
    fileprivate func setupUI() {
        setupPopUpBackgroundAlertView()
        setupTitleLabel()
        setupYesButton()
        setupNoButton()
    }

    func setupPopUpBackgroundAlertView() {
        self.view.addSubview(viewForAlert)
        viewForAlert.translatesAutoresizingMaskIntoConstraints = false
        viewForAlert.backgroundColor = UIColor.white
        NSLayoutConstraint.activate(
            [
                viewForAlert.centerXAnchor.constraint(
                    equalTo: view.centerXAnchor,
                    constant: 0
                ),
                viewForAlert.centerYAnchor.constraint(
                    equalTo: view.centerYAnchor,
                    constant: 0
                ),
                viewForAlert.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: 20
                ),
                viewForAlert.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -20
                ),
            ]
        )
        viewForAlert.setCornerRadius(radius: 20)
    }

    fileprivate func setupTitleLabel() {
        viewForAlert.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(
                    equalTo: viewForAlert.topAnchor,
                    constant: 32
                ),
                titleLabel.leadingAnchor.constraint(
                    equalTo: viewForAlert.leadingAnchor,
                    constant: 20
                ),
                titleLabel.trailingAnchor.constraint(
                    equalTo: viewForAlert.trailingAnchor,
                    constant: -20
                )
            ]
        )
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.regular(20)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .left
        titleLabel.text = "Do you want to remove this product from the Cart?"
    }

    private func setupYesButton() {
        viewForAlert.addSubview(yesButton)
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                yesButton.topAnchor.constraint(
                    equalTo: titleLabel.bottomAnchor,
                    constant: 20
                ),
                yesButton.leadingAnchor.constraint(
                    equalTo: viewForAlert.leadingAnchor,
                    constant: 20
                ),
                yesButton.trailingAnchor.constraint(
                    equalTo: viewForAlert.trailingAnchor,
                    constant: -20
                ),
                yesButton.heightAnchor.constraint(
                    equalToConstant: 38
                )
            ]
        )
        yesButton.setTitle(
            "Yes",
            for: .normal
        )
        
        yesButton.setTitleColor(UIColor.white, for: .normal)
        yesButton.titleLabel?.font = UIFont.medium(14)
        yesButton.backgroundColor = UIColor.blackButtonColor
        yesButton.titleLabel?.textAlignment = .center
        yesButton.setCornerRadius(radius: 19)
        yesButton.addTarget(self, action: #selector(yesButtonClicked), for: .touchUpInside)
    }
    
    private func setupNoButton() {
        viewForAlert.addSubview(noButton)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                noButton.topAnchor.constraint(
                    equalTo: yesButton.bottomAnchor,
                    constant: 10
                ),
                noButton.leadingAnchor.constraint(
                    equalTo: yesButton.leadingAnchor,
                    constant: 0
                ),
                noButton.trailingAnchor.constraint(
                    equalTo: yesButton.trailingAnchor,
                    constant: 0
                ),
                noButton.heightAnchor.constraint(
                    equalTo: yesButton.heightAnchor
                ),
                noButton.bottomAnchor.constraint(
                    equalTo: viewForAlert.bottomAnchor,
                    constant: -32
                ),
            ]
        )
        noButton.setTitle(
            "No",
            for: .normal
        )
        
        noButton.setTitleColor(UIColor.white, for: .normal)
        noButton.titleLabel?.font = UIFont.medium(14)
        noButton.backgroundColor = UIColor.blackButtonColor
        noButton.titleLabel?.textAlignment = .center
        noButton.setCornerRadius(radius: 19)
        noButton.addTarget(self, action: #selector(noButtonClicked), for: .touchUpInside)
    }
}

extension RemovefromCartVC {
    @objc func noButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func yesButtonClicked() {
        self.delegate?.didRemoveItemFromCart(savedItem: savedItem)
        self.dismiss(animated: true, completion: nil)
    }
}
