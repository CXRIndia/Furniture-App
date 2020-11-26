//
//  Chairs.swift
//  FurnitureAR
//
//  Created by akshay patil on 20/02/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//
import Foundation
import ObjectMapper

class Chairs: Mappable {
    
    var name: String?
    var price: String?
    var product_Dimensions : String?
    var color: String?
    var core_Materials: String?
    var style : String?
    var image: String?
    var id: String?
    var daeFileName: String?
    var rootNode: String?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                  <- map["Id"]
        name                <- map["Name"]
        price               <- map["Price"]
        product_Dimensions  <- map["Product_Dimensions"]
        color               <- map["Color"]
        core_Materials      <- map["Core_Materials"]
        style               <- map["Style"]
        image               <- map["Image"]
        daeFileName         <- map["DaeFileName"]
        rootNode            <- map["RootNode"]
    }
}



