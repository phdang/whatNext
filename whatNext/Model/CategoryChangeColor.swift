//
//  CategoryChangeColor.swift
//  whatNext
//
//  Created by HAI DANG on 12/28/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryChangeColor : Object {
    
    @objc dynamic var id : Int = 0
    
    @objc dynamic var parentName : String = ""
    
    @objc dynamic var name : String = ""
    
    @objc dynamic var done : Bool = false
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "colors")
}
