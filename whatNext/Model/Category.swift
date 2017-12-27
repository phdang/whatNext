//
//  Category.swift
//  whatNext
//
//  Created by HAI DANG on 12/26/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import Foundation

import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    
    @objc dynamic var hexColor : String?
    
    let items = List<Item>()
}
