//
//  MapVC.swift
//  WeatherForecast
//
//  Created by Samuel Gervais on 2016-09-12.
//  Copyright © 2016 Samuel Gervais. All rights reserved.
//

import UIKit
import CoreLocation

class LocationVC : UIViewController {
    
    var locationManager: LocationManager = LocationManager()
    
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lenLabel: UILabel!
    
    override func viewDidLoad()
    {
        locationManager.locationChange = getCoordinateFromLocation
    }
    
    func getCoordinateFromLocation(withLatitude latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        self.latLabel.text = "Lat: \(latitude)"
        self.lenLabel.text = "Len: \(longitude)"
    }

}