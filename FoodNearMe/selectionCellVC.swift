//
//  selectionCellVC.swift
//  FoodNearMe
//
//  Created by Faisal Akhtar on 2017-04-10.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit

class selectionCellVC: UITableViewCell {

    @IBOutlet weak var display: UIImageView!
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!

    @IBOutlet weak var categories: UILabel!

    
    
    var store : Store! {
        
        didSet{
            
            self.updateUI()
            
        }
        
        
    }
    
    
    
    
    
    private  func updateUI()
    {
        if (store.img_url != "")  {
        self.display.sd_setImage(with: URL(string: store.img_url))
        }
        else if store.img_url == "" {
         
            
            print("OOOOOOOOOOOOOOOOOOOOOOOO")
        }
            
        
        self.title.text = store.name
        self.categories.text = store.category
        self.rating.text = "Rating: " + String(store.rating)
        
        
        
        
    }

        
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.bg.backgroundColor = UIColor.black
        // Configure the view for the selected state
    }
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.bg.backgroundColor = UIColor.black
    }


}
