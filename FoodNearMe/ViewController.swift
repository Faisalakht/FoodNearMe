//
//  ViewController.swift
//  FoodNearMe
//
//  Created by Faisal Akhtar on 2017-04-10.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        execute()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    func execute() {
        
        let accessToken = "292yUoPAh6M_cisc1r97GMkwqbV-NQnXnjo1kKeD0CtC1r4j0buVICrdKMnThF2KSZM8ZOuqSdInEX5mM5ZvkUvnRWhaVdo8Q9XEFKndW9nOy_B0Rv5xRCTLeALrWHYx"
        let method = "GET"
        let URL = NSURL(string: "https://api.yelp.com/v3/businesses/search?term=casual&latitude=43.7491620&longitude=-79.2208370&radius=1500")
        
        // tried setting params to all of the following 4:
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: URL as! URL)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        
        request.httpMethod = method
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
                    print(json)
                    let k = json["businesses"] as! [[String: AnyObject]]
                    for l in k {
                        let t = l["location"] as? NSDictionary
                        print(t?["address1"])
                        
                    }
                    
                    
                    
                    print("---------------------------")
                    print("---------------------------")
                }
                catch {
                    
                }
                
            } else {
                print(error)
            }
        }
        task.resume()
    }
    
}

    
    
    
    



