//
//  Utilities.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    static func iconSelector(from str : String, date: Date) -> UIImage {
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
