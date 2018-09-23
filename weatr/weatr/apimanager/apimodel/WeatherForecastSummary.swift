//
//  WeatherForecastSummary.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import HandyJSON

class WeatherForecastSummary<T : Weather> : HandyJSON {
    var summary : String?
    var icon : String?
    var data : [T]?
    
    required init() {
    }
    
}
