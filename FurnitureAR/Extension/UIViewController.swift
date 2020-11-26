//
//  UIViewController.swift
//  eprocessify-ios
//
//  Created by Apple on 05/12/19.
//  Copyright © 2019 CodeToArt Technology Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
   
    func hideNavigationBar(){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func showNavigationBar() {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
