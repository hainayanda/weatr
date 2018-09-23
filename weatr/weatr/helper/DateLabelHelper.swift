//
//  DateLabelHelper.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

public class DateLabelHelper {
    
    private var label : UILabel
    private var formatter : DateFormatter
    private var updateInterval : TimeInterval
    private var timer : Timer?
    
    public init(_ label : UILabel, formatter : DateFormatter, updateInterval : TimeInterval) {
        self.label = label
        self.formatter = formatter
        self.updateInterval = updateInterval
    }
    
    public func fire(){
        if timer?.isValid ?? false {
            return
        }
        timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true, block: { (timer) in
            let currentDate = Date()
            self.label.text = self.formatter.string(from: currentDate)
        })
    }
    
    public func stop(){
        if timer?.isValid ?? false {
            timer?.invalidate()
        }
    }
    
}
