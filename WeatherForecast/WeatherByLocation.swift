//
//  WeatherByLocation.swift
//  WeatherForecast
//
//  Created by Samuel Gervais on 2016-09-13.
//  Copyright © 2016 Samuel Gervais. All rights reserved.
//

import UIKit

enum Unit:Double {
    
    case Celcius = 273.15
    case Fahrenheit = 255.372
}

enum WindDirection:String {
    
    case North = "North"
    case South = "South"
    case East = "East"
    case West = "West"
    case NorthEast = "North-East"
    case NorthWest = "North-West"
    case SouthEast = "South-East"
    case SouthWest = "South-West"
    case Unknown = " "
}

enum BackgroundImageWeather: String {
    
    case Sunny = "Sunny.jpg"
    case Clouds = "Clouds.jpg"
    case Rain = "Rain.jpg"
    case RainAndSun = "RainSun.jpg"
    case Default = "Default.jpg"
}

class WeatherByLocation {
    
    private var _cityName:String = "nocity"
    private var _temperature:Double = 0
    private var _tempMax:Double = 0
    private var _tempMin:Double = 0
    private var _pressure:Double = 0
    private var _humidity:Double = 0
    private var _description:String = "nodescription"
    private var _windSpeed:Int = 0
    private var _windDirection:Int = 0
    private var _preferenceUnit = Unit.Celcius
    private var _id = 0
    
    var cityName: String {
        return _cityName
    }
    
    var temperature: Double {
        return  _temperature - _preferenceUnit.rawValue
    }
    
    var tempMax: Double {
        return _tempMax  - _preferenceUnit.rawValue
    }
    
    var tempMin: Double {
        return _tempMin  - _preferenceUnit.rawValue
    }
    
    var pressure: Double {
        return _pressure / 1000
    }
    
    var humidity: Double {
        return _humidity
    }
    
    var description: String {
        return _description
    }
    
    var windSpeed: Int {
        return _windSpeed
    }
    
    var windDirectionDegrees: Int {
        return _windDirection
    }
    
    var winDirection: WindDirection {
        if _windDirection == 0{
            return .East
        }
        if _windDirection > 0 && _windDirection < 90 {
            return .NorthEast
        }
        if _windDirection == 90{
            return .North
        }
        if _windDirection > 90 && _windDirection < 180 {
            return .NorthWest
        }
        if _windDirection == 180{
            return .West
        }
        if _windDirection > 180 && _windDirection < 270 {
            return .SouthWest
        }
        if _windDirection == 270{
            return .South
        }
        if _windDirection > 270 && _windDirection < 360 {
            return .SouthEast
        }
        else {
            return .Unknown
        }
    }
    var id: Int {
        return _id
    }
    
    var backgroundImageWeather: UIImage {
        if _id == 800 {
            return WeatherImageFactory.imageForWeather(.Sunny)
        }
        if _id == 801 {
            return WeatherImageFactory.imageForWeather(.Clouds)
        }
        if _id == 520 {
            return WeatherImageFactory.imageForWeather(.RainAndSun)
        }
        if _id == 500 {
            return WeatherImageFactory.imageForWeather(.Rain)
        }
        else {
            return WeatherImageFactory.imageForWeather(.Default)
        }
    }
    
    init(dictionary: [String: AnyObject], unit:Unit){
        if let mainFeature = dictionary["main"] as? [String:AnyObject]{
            if let temperatureDictionary = mainFeature["temp"] as? Double{
                _temperature = temperatureDictionary
            }
            if let temperatureMaxDictionary = mainFeature["temp_max"] as? Double{
                _tempMax = temperatureMaxDictionary
            }
            if let temperatureMinDictionary = mainFeature["temp_min"] as? Double{
                _tempMin = temperatureMinDictionary
            }
            if let pressureDictionary = mainFeature["pressure"] as? Double {
                _pressure = pressureDictionary
            }
            if let humidityDictionary = mainFeature["humidity"] as? Double {
                _humidity = humidityDictionary
            }
        }
        if let windFeature = dictionary["wind"] as? [String:AnyObject]{
            if let speedDictionary = windFeature["speed"] as? Int{
                _windSpeed = speedDictionary
            }
            if let directionDictionary = windFeature["deg"] as? Int{
                _windDirection = directionDictionary
            }
        }
        if let weatherFeature = dictionary["weather"] as? [[String:AnyObject]]{
            let dictionaryArray = weatherFeature.first
            if let descriptionDictionary = dictionaryArray?["description"] as? String{
                _description = descriptionDictionary
            }
            if let idDictionary = dictionaryArray?["id"] as? Int{
                _id = idDictionary
            }
        }
        if let nameFeature = dictionary["name"] as? String{
            _cityName = nameFeature
        }
        _preferenceUnit = unit
    }
    
    func roundToPlaces(value:Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
}
