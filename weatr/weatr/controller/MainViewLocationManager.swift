//
//  MainViewLocationManager.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import CoreLocation

extension MainViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location : CLLocationCoordinate2D = locations.last?.coordinate {
            self.lastLocation = location
            let now = Date()
            if lastUpdate == nil {
                lastUpdate = now
                weatherApiManager.getForecast(in: location, unit: self.unit, delegate: self)
            }
                //only update after 5 minutes
            else if let lastUpdate : Date = self.lastUpdate, now.timeIntervalSince(lastUpdate) > 300 {
                self.lastUpdate = now
                weatherApiManager.getForecast(in: location, unit: self.unit, delegate: self)
            }
        }
    }
    
}
