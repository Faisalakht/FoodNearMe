//
//  NavLabel.swift
//  FoodNearMe
//
//  Created by Faisal Akhtar on 2017-04-10.
//  Copyright © 2017 Home. All rights reserved.
//

import Foundation


class Item {
    
    
    var lbl: String;
    var imgName: String;
    
    init(lbl: String, imgName: String){
        
        self.lbl = lbl
        self.imgName = imgName
        
    }
    
    
    class func getNavItems() -> [Item]
    {
        var navItems = [Item]()
        var lblarr = ["Fast Food","Bar","Fine Dining","Dessert","Cafe","Vegetarian"]
        
    
        for k in 0...5 {
            
            let navindex = Item(lbl: lblarr[k], imgName: "i\(k)")
            
            navItems.append(navindex)
        }
        
        
        
        return navItems
    }
    
    
    
}
