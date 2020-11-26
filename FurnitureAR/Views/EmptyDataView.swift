//
//  EmptyDataView.swift
//  Hollarhype
//
//  Created by Apple on 05/04/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit


class EmptyDataView: UIView {

    fileprivate let viewData = UIView()
    fileprivate let errorImageView = UIImageView()
    fileprivate let errorMessageLabel = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configureView(descriptionText:String) {
        errorMessageLabel.text = descriptionText
    }
}

extension EmptyDataView {
    
    private func setupUI() {
        setupviewData()
        setupTitleImageView()
        setupErrorLabel()
    }
    
    fileprivate func setupviewData() {
        addSubview(viewData)
        viewData.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                viewData.centerXAnchor.constraint(
                    equalTo: centerXAnchor
                ),
                viewData.centerYAnchor.constraint(
                    equalTo: centerYAnchor,
                    constant: -56
                ),
                viewData.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: 0
                ),
                viewData.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -0
                )
            ]
        )
    }
    
    func setupTitleImageView() {
        viewData.addSubview(errorImageView)
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        errorImageView.backgroundColor = .clear
        NSLayoutConstraint.activate(
            [
           
                errorImageView.topAnchor.constraint(
                equalTo: viewData.topAnchor,
                constant: 16
                ),
                errorImageView.centerXAnchor.constraint(
                equalTo: viewData.centerXAnchor,
                constant: 0
                ),
                errorImageView.heightAnchor.constraint(equalToConstant: 176)
         ]
        )
        errorImageView.image = UIImage(named: "NoItemImage")
        errorImageView.contentMode = .scaleAspectFit
    }
    
    fileprivate func setupErrorLabel() {
        viewData.addSubview(errorMessageLabel)
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                errorMessageLabel.leadingAnchor.constraint(
                    equalTo: viewData.leadingAnchor,
                    constant: 23
                ),
                errorMessageLabel.trailingAnchor.constraint(
                    equalTo: viewData.trailingAnchor,
                    constant: -23
                ),
                errorMessageLabel.topAnchor.constraint(
                    equalTo: errorImageView.bottomAnchor,
                    constant: 16
                ),
                errorMessageLabel.bottomAnchor.constraint(
                    equalTo: viewData.bottomAnchor,
                    constant: -16
                )
            ]
        )
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = UIColor.black
       // errorMessageLabel.text = "Uh-oh, looks like your Wishlist is empty."
        errorMessageLabel.font = UIFont.regular(23)
    }
}

