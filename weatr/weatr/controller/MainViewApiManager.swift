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
    
    func loadPlacePicture(placeName : String){
        placeApiManager.getPhoto(of: placeName) { (image, e) in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, animations: {
                    self.loadingView.alpha = 0
                }) { (_) in
                    self.loadingView.stopAnimating()
                }
            }
            guard let image : UIImage = image else {
                //SHOW FAILED MESSAGE
                return;
            }
            DispatchQueue.main.async {
                self.background.image = image
                UIView.animate(withDuration: 0.2, animations: {
                    self.blurBackground.alpha = 0
                })
            }
        }
    }
    
    func eatrOnBeforeSending(_ sessionToSend: URLSession) -> URLSession {
        labelLoadingView.startAnimating()
        loadingView.startAnimating()
        UIView.animate(withDuration: 0.2) {
            self.loadingView.alpha = 1
            self.blurBackground.alpha = 1
            self.labelLoadingView.alpha = 1
        }
        return sessionToSend
    }
    
    func eatrOnTimeout() {
        // SHOW FAILED MESSAGE
    }
    
    func eatrOnError(_ error: Error) {
        // SHOW FAILED MESSAGE
    }
    
    func eatrOnResponded(_ response: EatrResponse) {
        guard response.isSuccess, let json : ForecastModel = response.parsedBody() else {
            return
        }
        self.lastForecast = json
        let place = json.timezone?.components(separatedBy: "/")[1]
        if let place : String = place {
            DispatchQueue.main.async {
                self.loadPlacePicture(placeName: place)
            }
        }
        DispatchQueue.main.async {
            if let timeNow : Int64 = json.currently?.time {
                let date = Date.init(timeIntervalSince1970: (TimeInterval(timeNow)))
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM, hh.mm"
                let dateStr = formatter.string(from: date)
                self.navigationBar.topItem?.title = "updated on \(dateStr)"
            }
            self.cityLabel.text = place
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
