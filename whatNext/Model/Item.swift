//
//  Item.swift
//  whatNext
//
//  Created by HAI DANG on 12/26/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    
    @objc dynamic var title : String = ""
    
    @objc dynamic var done : Bool = false
    
    @objc dynamic var createdAt : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
