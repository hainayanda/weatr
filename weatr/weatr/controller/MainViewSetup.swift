//
//  MainViewSetup.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController {
    
    func createImageBackground() -> (UIImageView, UIVisualEffectView) {
        let imageView = UIImageView.init(frame: self.view.bounds)
        imageView.backgroundColor = UIColor.gray
        let blurEffect = UIBlurEffect.init(style: .light)
        let blurLayer = UIVisualEffectView.init(effect: blurEffect)
        blurLayer.frame = self.view.bounds
        blurLayer.alpha = 0
        self.view.addSubview(imageView)
        self.view.addSubview(blurLayer)
        return (imageView, blurLayer)
    }
    
    func createTableView() -> UITableView {
        let tableView = UITableView.init(frame: self.view.bounds)
        tableView.allowsSelection = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.alwaysBounceHorizontal = false
        tableView.backgroundColor = .clear
        self.view.addSubview(tableView)
        return tableView
    }
    
    func createWeatherLabel() -> (UIView, UIImageView, UILabel, UILabel, UILabel) {
        let container = UIView()
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(container)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            guide.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: firstCellHeight + 18),
            container.leftAnchor.constraint(equalTo: guide.leftAnchor),
            container.rightAnchor.constraint(equalTo: guide.rightAnchor)
            ])
        
        let weatherIcon = UIImageView.init(image: #imageLiteral(resourceName: "ic_clear_day"))
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(weatherIcon)
        NSLayoutConstraint.activate([
            weatherIcon.heightAnchor.constraint(equalToConstant: 36),
            weatherIcon.widthAnchor.constraint(equalToConstant: 36),
            weatherIcon.topAnchor.constraint(equalTo: container.layoutMarginsGuide.topAnchor),
            weatherIcon.leftAnchor.constraint(equalTo: container.layoutMarginsGuide.leftAnchor, constant : 9)
            ])
        
        let weatherLabel = UILabel()
        weatherLabel.textColor = .white
        weatherLabel.text = "weather"
        weatherLabel.font = UIFont.systemFont(ofSize: 20)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(weatherLabel)
        NSLayoutConstraint.activate([
            weatherLabel.leftAnchor.constraint(equalTo: weatherIcon.rightAnchor, constant: 18),
            weatherLabel.centerYAnchor.constraint(equalTo: weatherIcon.centerYAnchor),
            container.layoutMarginsGuide.rightAnchor.constraint(greaterThanOrEqualTo: weatherLabel.rightAnchor, constant : 9)
            ])
        
        let temperatureLabel = UILabel()
        temperatureLabel.textColor = .white
        temperatureLabel.text = "0°"
        temperatureLabel.font = UIFont.systemFont(ofSize: 135)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.leftAnchor.constraint(equalTo: container.layoutMarginsGuide.leftAnchor, constant : 9),
            container.layoutMarginsGuide.rightAnchor.constraint(greaterThanOrEqualTo: temperatureLabel.rightAnchor, constant : 9),
            temperatureLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant : -18)
            ])
        
        let cityLabel = UILabel()
        cityLabel.textColor = .white
        cityLabel.text = "City"
        cityLabel.font = UIFont.systemFont(ofSize: 16)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.leftAnchor.constraint(equalTo: container.layoutMarginsGuide.leftAnchor, constant : 18),
            container.layoutMarginsGuide.rightAnchor.constraint(greaterThanOrEqualTo: cityLabel.rightAnchor, constant : 9),
            cityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant : -18),
            container.layoutMarginsGuide.bottomAnchor.constraint(equalTo: cityLabel.bottomAnchor)
            ])
        return (container, weatherIcon, weatherLabel, temperatureLabel, cityLabel)
    }
    
    func createNavigationBar(drawer dAction : Selector, search sAction : Selector) -> UINavigationBar {
        let navBar = UINavigationBar()
        
        let navItem = UINavigationItem()
        
        let dButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 36, height: 36))
        dButton.setImage(#imageLiteral(resourceName: "ic_burger_menu"), for: .normal)
        dButton.imageEdgeInsets = UIEdgeInsets.init(top: 9, left: 0, bottom: 9, right: 23)
        let drawerButton = UIBarButtonItem.init(customView: dButton)
        dButton.addTarget(self, action: sAction, for: .touchUpInside)
        navItem.leftBarButtonItem = drawerButton
        
        let sButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 36, height: 36))
        sButton.setImage(#imageLiteral(resourceName: "ic_magnifier"), for: .normal)
        sButton.imageEdgeInsets = UIEdgeInsets.init(top: 9, left: 23, bottom: 9, right: 0)
        let searchButton = UIBarButtonItem.init(customView: sButton)
        sButton.addTarget(self, action: sAction, for: .touchUpInside)
        navItem.rightBarButtonItem = searchButton
        
        navBar.setItems([navItem], animated: false)
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        navBar.backgroundColor = UIColor.clear
        navBar.tintColor = UIColor.white
        navBar.translatesAutoresizingMaskIntoConstraints = false
        
        let topView = TranslucentView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(topView)
        self.view.addSubview(navBar)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            navBar.heightAnchor.constraint(equalToConstant: 44),
            navBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            topView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            navBar.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.bottomAnchor.constraint(equalTo: topView.bottomAnchor)
            ])
        return navBar
    }
}