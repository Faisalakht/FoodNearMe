//
//  menuCellVC.swift
//  FoodNearMe
//
//  Created by Faisal Akhtar on 2017-04-10.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit

class menuCellVC: UITableViewCell {


    @IBOutlet weak var imgbg: UIImageView!
    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var navlbl: UILabel!
    
    
    var item : Item! {
        
        didSet{
            
            self.updateUI()
            
        }
        
        
    }
    
    
    
    
    
  private  func updateUI()
    {
        
        self.imgbg.image = UIImage(named: item.imgName)
        self.navlbl.text = item.lbl
        
        
        
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.shadow.backgroundColor = UIColor.black;
        self.shadow.alpha = 0.75
        
    }
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.shadow.backgroundColor = UIColor.black;
        self.shadow.alpha = 0.75
    }

}
