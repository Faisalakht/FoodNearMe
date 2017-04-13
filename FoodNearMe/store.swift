//
//  store.swift
//  FoodNearMe
//
//  Created by Faisal Akhtar on 2017-04-10.
//  Copyright © 2017 Home. All rights reserved.
//

import Foundation

class Store {
    
    let name: String
    let img_url: String
    let rating: Double
    let category: String
    let longitude: Double
    let latitude: Double
    let address: String
    let phone: String
    
    init(name:String,img_url:String,rating:Double,category:String,longitude: Double, latitude: Double, address: String, phone: String) {
        self.name = name
        self.img_url = img_url
        self.rating = rating
        self.category = category
        self.longitude = longitude
        self.latitude = latitude
        self.address = address
        self.phone = phone
    }
    
    
    
    
    class  func execute() -> [Store] {
        var arr = [Store]()
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
                    let str = json["businesses"] as! [[String: AnyObject]]
                    
                    for indx in str {
                        let name = indx["name"]! as! String
                        let img_url = indx["image_url"]! as! String
                        var categories = String()
                        let temp1 = indx["categories"] as? [[String: AnyObject]]
                        for indx2  in temp1! {
                            categories +=  indx2["title"]! as! String
                            categories += " "
                        }
                        let rating = indx["rating"]! as! Double
                        let loc = indx["coordinates"] as? NSDictionary
                        let longitude = loc?["longitude"]! as! Double
                        let latitude = loc?["latitude"]! as! Double
                        let d2 = indx["location"] as? NSDictionary
                        let indx3 = d2?["display_address"] as! NSArray
                        let phone = indx["display_phone"]! as! String
                        var address = indx3[0] as! String + ", "
                        address += indx3[1] as! String + ", "
                        address += indx3[2] as! String
                        print ("++++++++++++++++++++++++++",address)
                        print(phone)
                        print (longitude,latitude)
                        print(categories,rating)
                        print(name,img_url)
                        //let t = indx["location"] as? NSDictionary
                        //print(t?["address1"])
                        
                        //let newStr = Store(name: name, img_url: img_url, rating: rating, category: categories, longitude: longitude, latitude: latitude, address: address, phone: phone)
                        DispatchQueue.main.async {
                            arr.append(Store(name: name, img_url: img_url, rating: rating, category: categories, longitude: longitude, latitude: latitude, address: address, phone: phone))
                        }
                        
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
        
        
        
        
        return arr
    }
    
    
    
    
}
