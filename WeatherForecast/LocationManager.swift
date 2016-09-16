//
//  LocationManager.swift
//  WeatherForecast
//
//  Created by Samuel Gervais on 2016-09-14.
//  Copyright © 2016 Samuel Gervais. All rights reserved.
//

import CoreLocation
import UIKit

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationChange:((latitude: CLLocationDegrees, longitude: CLLocationDegrees)->Void)?

    private let locationManager = CLLocationManager()
    
    override init(){
        super.init()

        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.distanceFilter = 3000.0 //meters
            locationManager.startUpdatingLocation()
        }
    }
    
    func userLocation() -> CLLocation? {
        return self.locationManager.location
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue:CLLocationCoordinate2D = manager.location?.coordinate else {
            return }
        locationChange?(latitude: locValue.latitude,longitude:locValue.longitude)
    }
}
