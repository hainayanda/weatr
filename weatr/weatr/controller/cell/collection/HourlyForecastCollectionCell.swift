//
//  HourlyForecastCollectionCell.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

class HourlyForecastCollectionCell : UICollectionViewCell {
    
    var weatherIcon : UIImageView!
    var hourLabel : UILabel!
    var temperatureLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        assemblyCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func apply(using model : Weather){
        temperatureLabel.text = model.temperature == nil ? "No Data" : "\(Int(model.temperature!))°"
        weatherIcon.image = Utilities.iconSelector(from: model.icon ?? "", date: model.time != nil ? Date.init(timeIntervalSince1970: (TimeInterval(model.time!))) : Date())
        if let time : Int64 = model.time {
            let date = Date.init(timeIntervalSince1970: (TimeInterval(time)))
            let formatter = DateFormatter()
            formatter.dateFormat = "ha"
            let dateStr = formatter.string(from: date)
            hourLabel.text = dateStr
        }
    }
    
    func assemblyCell(){
        self.contentView.backgroundColor = .clear
        
        hourLabel = UILabel()
        hourLabel.textColor = .white
        hourLabel.font = UIFont.systemFont(ofSize: 12)
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(hourLabel)
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            hourLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
            ])
        
        temperatureLabel = UILabel()
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont.systemFont(ofSize: 12)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
            ])
        
        weatherIcon = UIImageView()
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(weatherIcon)
        NSLayoutConstraint.activate([
            weatherIcon.heightAnchor.constraint(equalToConstant: 36),
            weatherIcon.widthAnchor.constraint(equalToConstant: 36),
            weatherIcon.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            weatherIcon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
            ])
        
        
    }
    
}
