//
//  WeatherAPIManager.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import Eatr
import CoreLocation

enum Unit {
    case metric, imperial
}

class WeatherAPIManager {
    
    public static var sharedInstance = WeatherAPIManager()
    
    public let operationQueue : OperationQueue
    
    //darksy.net api
    private var API_KEY = "c6895ca2f03b1d0a116a2dae7ed1fba4"
    
    private init() {
        operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
    }
    
    public func getForecast(in location : CLLocationCoordinate2D, unit : Unit, delegate : EatrDelegate)
    {
        let url = "https://api.darksky.net/forecast/{0}/{1},{2}".replacingOccurrences(of: "{0}", with: API_KEY).replacingOccurrences(of: "{1}", with: "\(location.latitude)").replacingOccurrences(of: "{2}", with: "\(location.longitude)")
        EatrRequestBuilder.httpGet.set(url: url).addParam(withKey: "units", andValue: unit == .metric ? "si" : "us").set(operationQueue: operationQueue).set(delegate: delegate).asyncExecute()
    }
}
