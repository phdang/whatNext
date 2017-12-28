//
//  Color.swift
//  whatNext
//
//  Created by HAI DANG on 12/28/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import Foundation
import ChameleonFramework

class Color {
    
    var hexColor : String 
    
    var color : UIColor
    
    var colorName : String
    
    init(colorFlat: UIColor, hex : String, name : String) {
        
        color = colorFlat
        
        hexColor = hex
        
        colorName = name
    }
    
    
    
}




