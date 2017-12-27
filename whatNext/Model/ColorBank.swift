//
//  ColorBank.swift
//  whatNext
//
//  Created by HAI DANG on 12/28/17.
//  Copyright © 2017 HAI DANG. All rights reserved.
//

import Foundation
import ChameleonFramework

class ColorBank {
    
    var list = [Color] ()
    
    init() {
        
        list.append(Color(colorFlat: FlatRed(), hex: FlatRed().hexValue(), name: "Red"))
        list.append(Color(colorFlat: FlatOrange(), hex: FlatOrange().hexValue(), name: "Orange"))
        list.append(Color(colorFlat: FlatYellow(), hex: FlatYellow().hexValue(), name: "Yellow"))
        list.append(Color(colorFlat: FlatSand(), hex: FlatSand().hexValue(), name: "Sand"))
        list.append(Color(colorFlat: FlatNavyBlue(), hex: FlatNavyBlue().hexValue(), name: "Navy Blue"))
        list.append(Color(colorFlat: FlatBlack(), hex: FlatBlack().hexValue(), name: "Black"))
        list.append(Color(colorFlat: FlatMagenta(), hex: FlatMagenta().hexValue(), name: "Magenta"))
        list.append(Color(colorFlat: FlatTeal(), hex: FlatTeal().hexValue(), name: "Teal"))
        list.append(Color(colorFlat: FlatSkyBlue(), hex: FlatSkyBlue().hexValue(), name: "Sky Blue"))
        list.append(Color(colorFlat: FlatGreen(), hex: FlatGreen().hexValue(), name: "Green"))
        list.append(Color(colorFlat: FlatMint(), hex: FlatMint().hexValue(), name: "Mint"))
        list.append(Color(colorFlat: FlatWhite(), hex: FlatWhite().hexValue(), name: "White"))
        list.append(Color(colorFlat: FlatGray(), hex: FlatGray().hexValue(), name: "Gray"))
        list.append(Color(colorFlat: FlatForestGreen(), hex: FlatForestGreen().hexValue(), name: "Forest Green"))
        list.append(Color(colorFlat: FlatPurple(), hex: FlatPurple().hexValue(), name: "Purple"))
        list.append(Color(colorFlat: FlatBrown(), hex: FlatBrown().hexValue(), name: "Brown"))
        list.append(Color(colorFlat: FlatPlum(), hex: FlatPlum().hexValue(), name: "Plum"))
        list.append(Color(colorFlat: FlatWatermelon(), hex: FlatWatermelon().hexValue(), name: "Watermelon"))
        list.append(Color(colorFlat: FlatLime(), hex: FlatLime().hexValue(), name: "Lime"))
        list.append(Color(colorFlat: FlatPink(), hex: FlatPink().hexValue(), name: "Pink"))
        list.append(Color(colorFlat: FlatMaroon(), hex: FlatMaroon().hexValue(), name: "Maroon"))
        list.append(Color(colorFlat: FlatCoffee(), hex: FlatCoffee().hexValue(), name: "Coffe"))
        list.append(Color(colorFlat: FlatPowderBlue(), hex: FlatPowderBlue().hexValue(), name: "Powder Blue"))
        list.append(Color(colorFlat: FlatBlue(), hex: FlatBlue().hexValue(), name: "Blue"))
        
    }
    
    
    
}
