//
//  ForecastModel.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import HandyJSON

class ForecastModel : HandyJSON {
    var latitude : Double?
    var longitude : Double?
    var timezone : String?
    var currently : Weather?
    var hourly : WeatherForecastSummary<Weather>?
    var daily : WeatherForecastSummary<DailyWeather>?
    
    required init() { }
    
}
