//
//  MenuVC.swift
//  FoodNearMe
//
//  Created by Faisal Akhtar on 2017-04-10.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit
import CoreLocation



class MenuVC: UITableViewController, CLLocationManagerDelegate {
    var locationManager:CLLocationManager?
    var currentLocation:CLLocation?;
    
    var menu = Item.getNavItems()
    var stores = [Store]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()

        //execute()
        print("-------LOADING NAV ITEMS-------------",menu.count)
        self.tableView.rowHeight = 230.0;
        self.tableView.dataSource = self;
        
    }

    override func viewDidAppear(_ animated: Bool) {
       self.stores.removeAll()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! menuCellVC

        cell.item = menu[indexPath.row]

        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lat = self.currentLocation!.coordinate.latitude
        let long = self.currentLocation!.coordinate.longitude
        if indexPath.row == 0{
                execute(apiurl: "https://api.yelp.com/v3/businesses/search?term=fast%20food&latitude=\(lat)&longitude=\(long)&radius=1500")
             DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
             print(self.stores)
            }
        }
        else if indexPath.row == 1 {
            print("this is it")
            execute(apiurl: "https://api.yelp.com/v3/businesses/search?term=bars&latitude=\(lat)&longitude=\(long)&radius=1500")
             execute(apiurl: "https://api.yelp.com/v3/businesses/search?term=pubs&latitude=\(lat)&longitude=\(long)&radius=1500")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print(self.stores)
            }
        } else if indexPath.row == 2
        {
            
            execute(apiurl: "https://api.yelp.com/v3/businesses/search?term=fine%20dining&latitude=\(lat)&longitude=\(long)&radius=1500")
            execute(apiurl: "https://api.yelp.com/v3/businesses/search?term=fancy&latitude=\(lat)&longitude=\(long)&radius=1500")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print(self.stores)
            }
            
        }
        else if indexPath.row == 3
        {
            execute(apiurl: "https://api.yelp.com/v3/businesses/search?term=dessert&latitude=\(lat)&longitude=\(long)&radius=1500")
            execute(apiurl: "https://api.yelp.com/v3/businesses/search?term=cake&latitude=\(lat)&longitude=\(long)&radius=1500")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print(self.stores)
            }
            
        }
        else if indexPath.row == 4
        {
            execute(apiurl: "https://api.yelp.com/v3/businesses/search?term=cafe&latitude=\(lat)&longitude=\(long)&radius=1500")
            execute(apiurl: "https://api.yelp.com/v3/businesses/search?term=bakery&latitude=\(lat)&longitude=\(long)&radius=1500")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print(self.stores)
            }

        
            
            
        }
        else if indexPath.row == 5
        {
            execute(apiurl: "https://api.yelp.com/v3/businesses/search?term=vegan&latitude=\(lat)&longitude=\(long)&radius=1500")
            execute(apiurl: "https://api.yelp.com/v3/businesses/search?term=vegetarian&latitude=\(lat)&longitude=\(long)&radius=1500")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print(self.stores)
            }
            
            
            
            
        }
        locationManager?.stopUpdatingLocation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        self.performSegue(withIdentifier: "selectionSeg", sender: self);
        }
    }
    
    
    

    
    
    
    func execute(apiurl: String) {
        var counter = 0
        let accessToken = "292yUoPAh6M_cisc1r97GMkwqbV-NQnXnjo1kKeD0CtC1r4j0buVICrdKMnThF2KSZM8ZOuqSdInEX5mM5ZvkUvnRWhaVdo8Q9XEFKndW9nOy_B0Rv5xRCTLeALrWHYx"
        let method = "GET"
        let URL = NSURL(string: apiurl)
        
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
                        var address = String()
                        for parts in indx3{
                            
                            address += parts as! String + " "
                        }
                        print ("++++++++++++++++++++++++++",address)
                        print(phone)
                        print (longitude,latitude)
                        print(categories,rating)
                        print(name,img_url)
                        //let t = indx["location"] as? NSDictionary
                        //print(t?["address1"])
                        
                        //let newStr = Store(name: name, img_url: img_url, rating: rating, category: categories, longitude: longitude, latitude: latitude, address: address, phone: phone)
                        self.stores.append(Store(name: name, img_url: img_url, rating: rating, category: categories, longitude: longitude, latitude: latitude, address: address, phone: phone))
                        counter += 1
                        
                    }
                    
                    
                    
                    print("---------------------------")
                    print(counter)
                }
                catch {
                    
                }
                
            } else {
                print(error)
            }
        }
        task.resume()
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations[0]
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "selectionSeg") {
            
            
            let viewController = segue.destination as! selectionVC;
            viewController.stores = self.stores
        }
    }
    
    
    
    
    
 
}
