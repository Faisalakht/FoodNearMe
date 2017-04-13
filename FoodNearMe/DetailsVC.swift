//
//  DetailsVC.swift
//  FoodNearMe
//
//  Created by Faisal Akhtar on 2017-04-10.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DetailsVC: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {

    var spec_store = [Store]();
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var categories: UILabel!
    
    @IBOutlet weak var ratings: UILabel!
    
    @IBOutlet weak var locationaddress: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    
    
    @IBOutlet weak var maplocation: MKMapView!
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        print("------------IN DETAILS VIEW----------------",spec_store)
        name.text = spec_store[0].name
        categories.text = "Category: " + spec_store[0].category
        ratings.text = "Rating: " + String(spec_store[0].rating)
        locationaddress.text = "Address: " + spec_store[0].address
        phone.text = "Phone: " + spec_store[0].phone
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        maplocation.delegate = self;
        self.maplocation.isZoomEnabled = true;
        self.maplocation.isUserInteractionEnabled = true;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.02, 0.02)
        let myloc : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myloc,span: span)
        maplocation.setRegion(region, animated: true);
        self.maplocation.showsUserLocation = true
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2DMake(spec_store[0].latitude, spec_store[0].longitude)
        maplocation.addAnnotation(pin)
        
    }
    
    
    

}
