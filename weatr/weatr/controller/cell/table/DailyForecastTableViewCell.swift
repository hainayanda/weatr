//
//  DailyForecastTableView.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

class DailyForecastTableViewCell : UITableViewCell {
    
    var blurLayer : UIVisualEffectView!
    
    var summaryLabel : UILabel!
    var dayLabel : UILabel!
    var weatherIcon : UIImageView!
    var temperatureHigh : UILabel!
    var temperatureLow : UILabel!
    var data : DailyWeather?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        assemblyCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        blurLayer.layer.cornerRadius = 18
        blurLayer.clipsToBounds = true
    }
    
    func apply(using model : DailyWeather){
        data = model
        if let time : Int64 = model.time {
            let date = Date.init(timeIntervalSince1970: (TimeInterval(time)))
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            dayLabel.text = formatter.string(from: date)
        }
        summaryLabel.text = model.summary
        weatherIcon.image = Utilities.iconSelector(from: model.icon ?? "", date: model.time != nil ? Date.init(timeIntervalSince1970: (TimeInterval(model.time!))) : Date())
        temperatureHigh.text = model.temperatureHigh == nil ? "No Data" : "\(Int(model.temperatureHigh!))°"
        temperatureLow.text = model.temperatureLow == nil ? "No Data" : "\(Int(model.temperatureLow!))°"
    }
    
    func assemblyCell(){
        contentView.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect.init(style: .dark)
        blurLayer = UIVisualEffectView.init(effect: blurEffect)
        blurLayer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(blurLayer)
        NSLayoutConstraint.activate([
            blurLayer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4.5),
            contentView.bottomAnchor.constraint(equalTo: blurLayer.bottomAnchor, constant: 4.5),
            blurLayer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18),
            contentView.rightAnchor.constraint(equalTo: blurLayer.rightAnchor, constant : 18)
            ])
        
        dayLabel = UILabel()
        dayLabel.textColor = .white
        dayLabel.font = UIFont.systemFont(ofSize: 18)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dayLabel)
        NSLayoutConstraint.activate([
            dayLabel.leftAnchor.constraint(equalTo: blurLayer.leftAnchor, constant: 18),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -9)
            ])
        
        temperatureLow = UILabel()
        temperatureLow.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        temperatureLow.font = UIFont.systemFont(ofSize: 14)
        temperatureLow.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(temperatureLow)
        NSLayoutConstraint.activate([
            blurLayer.rightAnchor.constraint(equalTo: temperatureLow.rightAnchor, constant: 18),
            temperatureLow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        temperatureHigh = UILabel()
        temperatureHigh.textColor = .white
        temperatureHigh.font = UIFont.systemFont(ofSize: 14)
        temperatureHigh.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(temperatureHigh)
        NSLayoutConstraint.activate([
            temperatureLow.leftAnchor.constraint(equalTo: temperatureHigh.rightAnchor, constant: 9),
            temperatureHigh.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        weatherIcon = UIImageView()
        weatherIcon.contentMode = .scaleAspectFit
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(weatherIcon)
        NSLayoutConstraint.activate([
            temperatureHigh.leftAnchor.constraint(equalTo: weatherIcon.rightAnchor, constant: 27),
            weatherIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherIcon.heightAnchor.constraint(equalToConstant: 45),
            weatherIcon.widthAnchor.constraint(equalToConstant: 45)
            ])
        
        summaryLabel = UILabel()
        summaryLabel.numberOfLines = 2
        summaryLabel.textColor = .white
        summaryLabel.font = UIFont.systemFont(ofSize: 11)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(summaryLabel)
        NSLayoutConstraint.activate([
            summaryLabel.leftAnchor.constraint(equalTo: blurLayer.leftAnchor, constant: 18),
            summaryLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant : 2),
            weatherIcon.leftAnchor.constraint(equalTo: summaryLabel.rightAnchor, constant : 9)
            ])
        
    }
}
