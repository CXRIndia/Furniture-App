
import Foundation
import ObjectMapper
import RealmSwift

class SavedItem: Object,Mappable {
    
    @objc dynamic var name: String?
    @objc dynamic var price: String?
    @objc dynamic var product_Dimensions : String?
    @objc dynamic var color: String?
    @objc dynamic var core_Materials: String?
    @objc dynamic var style : String?
    @objc dynamic var image: String?
    @objc dynamic var id: String?
    @objc dynamic var daeFileName: String?
    @objc dynamic var rootNode: String?
    @objc dynamic var itemCount: Int = 1
    @objc dynamic var itemInCart: Bool = false
    

    required convenience init(map: ObjectMapper.Map) {
        self.init()
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    func mapping(map: ObjectMapper.Map) {
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
        itemCount           <- map["ItemCount"]
        itemInCart          <- map["ItemInCart"]
    }
}



