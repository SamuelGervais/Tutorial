//
//  WeatherImageFactory.swift
//  WeatherForecast
//
//  Created by Samuel Gervais on 2016-09-14.
//  Copyright © 2016 Samuel Gervais. All rights reserved.
//

import Foundation
import UIKit

class WeatherImageFactory {
    
    static func imageForWeather(weather:BackgroundImageWeather) -> UIImage {
        
        switch weather {
        case .Sunny:
            
            if let sunnyImage = UIImage(named: BackgroundImageWeather.Sunny.rawValue){
                return sunnyImage
            }
            fallthrough
            
        case .Clouds:
            
            if let cloudsImage = UIImage(named: BackgroundImageWeather.Clouds.rawValue){
                return cloudsImage
            }
            fallthrough
            
        case .Rain:
            
            if let rainImage = UIImage(named: BackgroundImageWeather.Rain.rawValue){
                return rainImage
            }
            fallthrough
            
        case .RainAndSun:
            
            if let rainSunImage = UIImage(named: BackgroundImageWeather.RainAndSun.rawValue){
                return rainSunImage
            }
            
            fallthrough
        default:
            return UIImage(named: BackgroundImageWeather.Default.rawValue)!
        }
    }
    
}