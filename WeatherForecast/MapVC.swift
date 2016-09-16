//
//  MapVC.swift
//  WeatherForecast
//
//  Created by Samuel Gervais on 2016-09-15.
//  Copyright © 2016 Samuel Gervais. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {
    let regionRadius: CLLocationDistance = 1000
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager: LocationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        map.showsUserLocation = true
        locationManager.locationChange = AddLocationWithCoordinateOnMap
        
        if let location = locationManager.userLocation() {
            centerMapOnLocation(location)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func AddLocationWithCoordinateOnMap(withLatitude latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        centerMapOnLocation(initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
}
