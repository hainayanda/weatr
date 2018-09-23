//
//  CurrentWeather.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import HandyJSON

class Weather : HandyJSON {
    
    var time : Int64?
    var summary : String?
    var icon : String?
    var nearestStormDistance : Int?
    var nearestStormBearing : Int?
    var precipIntensity : Int?
    var precipProbability : Int?
    var temperature : Double?
    var apparentTemperature : Double?
    var dewPoint : Double?
    var humidity : Double?
    var pressure : Double?
    var windSpeed : Double?
    var windGust : Double?
    var windBearing : Int?
    var cloudCover : Int?
    var uvIndex : Int?
    var visibility : Int?
    var ozone : Double?
    
    required init() {
    }
    
}

class DailyWeather : Weather {
    
    var sunriseTime : Int64?
    var sunsetTime : Int64?
    var moonPhase : Double?
    var precipIntensityMax : Double?
    var precipIntensityMaxTime : Int64?
    var precipType : String?
    var temperatureHigh : Double?
    var temperatureHighTime : Int64?
    var temperatureLow : Double?
    var temperatureLowTime : Int64?
    var apparentTemperatureHigh : Double?
    var apparentTemperatureHighTime : Int64?
    var apparentTemperatureLow : Double?
    var apparentTemperatureLowTime : Int64?
    var windGustTime : Int64?
    var uvIndexTime : Int64?
    var temperatureMin : Double?
    var temperatureMinTime : Int64?
    var temperatureMax : Double?
    var temperatureMaxTime : Int64?
    var apparentTemperatureMin : Double?
    var apparentTemperatureMinTime : Int64?
    var apparentTemperatureMax : Double?
    var apparentTemperatureMaxTime : Int64?
    
    required init() {
    }
}
