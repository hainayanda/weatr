//
//  MainViewApiManager.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import Eatr

extension MainViewController : EatrDelegate {
    
    func eatrOnBeforeSending(_ sessionToSend: URLSession) -> URLSession {
        labelLoadingView.startAnimating()
        UIView.animate(withDuration: 0.2) {
            self.labelLoadingView.alpha = 1
        }
        return sessionToSend
    }
    
    func eatrOnTimeout() {
        
    }
    
    func eatrOnError(_ error: Error) {
        
    }
    
    func eatrOnResponded(_ response: EatrResponse) {
        guard response.isSuccess, let json : ForecastModel = response.parsedBody() else {
            return
        }
        self.lastForecast = json
        DispatchQueue.main.async {
            if let timeNow : Int64 = json.currently?.time {
                let date = Date.init(timeIntervalSince1970: (TimeInterval(timeNow)))
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM, hh.mm"
                let dateStr = formatter.string(from: date)
                self.navigationBar.topItem?.title = "updated on \(dateStr)"
            }
            self.cityLabel.text = json.timezone?.components(separatedBy: "/")[1]
            self.weatherLabel.text = json.currently?.summary
            let temperature = json.currently?.temperature
            self.temperatureLabel.text = temperature == nil ? "No Data" : "\(Int(temperature!))°"
            if let iconStr : String = json.currently?.icon {
                self.weatherIcon.image = self.iconSelector(from: iconStr, date: json.currently?.time != nil ? Date.init(timeIntervalSince1970: (TimeInterval((json.currently?.time)!))) : Date())
            }
            
        }
    }
    
    func eatrOnFinished() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.labelLoadingView.alpha = 0
            }) { (_) in
                self.labelLoadingView.stopAnimating()
            }
        }
    }
    
    func iconSelector(from str : String, date: Date) -> UIImage {
        let hour = Calendar.current.component(.hour, from: date)
        switch str {
        case "clear-day":
            return #imageLiteral(resourceName: "ic_clear_day")
        case "clear-night" :
            return #imageLiteral(resourceName: "ic_clear_night")
        case "rain" :
            return #imageLiteral(resourceName: "ic_rain")
        case "snow" :
            return #imageLiteral(resourceName: "ic_snow")
        case "sleet" :
            return #imageLiteral(resourceName: "ic_sleet")
        case "wind" :
            return #imageLiteral(resourceName: "ic_wind")
        case "fog" :
            return hour > 18 && hour < 6 ? #imageLiteral(resourceName: "ic_fog_night") : #imageLiteral(resourceName: "ic_fog_day")
        case "partly-cloudy-day":
            return #imageLiteral(resourceName: "ic_partly_cloudy_day")
        case "partly-cloudy-night" :
            return #imageLiteral(resourceName: "ic_partly_cloudy_night")
        case "thunderstorm" :
            return #imageLiteral(resourceName: "ic_thunderstorm")
        case "tornado" :
            return #imageLiteral(resourceName: "ic_tornado")
        default:
            return #imageLiteral(resourceName: "ic_cloudy")
        }
    }
    
}
