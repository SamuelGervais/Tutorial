//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Samuel Gervais on 2016-09-12.
//  Copyright © 2016 Samuel Gervais. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
        
    var currentWeather: WeatherByLocation?
    var locationManager: LocationManager = LocationManager()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempHighLowLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTopLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var rainProbLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.locationChange = getWeather
    }

    
    @IBAction func myUnwindAction(segue: UIStoryboardSegue){
        
    }
    
    func displayWeatherInformation(weather: WeatherByLocation){
        dispatch_async(dispatch_get_main_queue()) {
            
            self.nameLabel.text = weather.cityName
            self.temperatureLabel.text = "\(weather.roundToPlaces(weather.temperature, places: 1))°"
            self.tempHighLowLabel.text = "H \(weather.roundToPlaces(weather.tempMax, places: 1))° / L \(weather.roundToPlaces(weather.tempMin, places: 1))°"
            self.pressureLabel.text = "Pressure: \(weather.roundToPlaces(weather.pressure, places: 2)) mb"
            self.humidityLabel.text = "Humidity: \(weather.roundToPlaces(weather.humidity, places: 2))%"
            self.windDirectionLabel.text = weather.winDirection.rawValue
            self.windSpeedLabel.text = "Wind: \(weather.windSpeed) km/h"
            self.descriptionLabel.text = weather.description
            self.descriptionTopLabel.text = weather.description
            self.backgroundImage.image = weather.backgroundImageWeather
            print(weather.id)
            
        }
    }
    
    func getWeather(withLatitude latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=4b88fa0694bb2d1e1af88fdcd348b608"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        session.dataTaskWithURL(url) { (data: NSData?, response:NSURLResponse?, error: NSError?) -> Void in
            
            if let responseData = data {
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let dict = json as? Dictionary<String, AnyObject> {
                        
                        self.displayWeatherInformation(WeatherByLocation.init(dictionary: dict, unit: .Celcius))
                    }
                    
                } catch {
                    print("Could not serialize")
                }
            }
            }.resume()
    }
}

