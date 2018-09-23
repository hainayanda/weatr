//
//  MainViewController.swift
//  weatr
//
//  Created by Nayanda Haberty on 22/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MainViewController : UIViewController , UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    // UI COMPONENT
    
    weak var background : UIImageView!
    weak var loadingView : UIActivityIndicatorView!
    weak var blurBackground : UIVisualEffectView!
    weak var navigationBar : UINavigationBar!
    weak var tableOfContent : UITableView!
    weak var weatherLabelsContainer : UIView!
    weak var weatherIcon : UIImageView!
    weak var weatherLabel : UILabel!
    weak var temperatureLabel : UILabel!
    weak var cityLabel : UILabel!
    weak var dateLabel : UILabel!
    weak var labelLoadingView : UIActivityIndicatorView!
    
    // CONSTANT
    
    let weatherApiManager = WeatherAPIManager.sharedInstance
    let placeApiManager = PlaceAPIManager.sharedInstance
    let defaultLocation = CLLocationCoordinate2D.init(latitude: -6.21462, longitude: 106.84513) //JAKARTA
    let firstCellHeight : CGFloat = 120
    let locationManager = CLLocationManager()
    let hourlyCellId = "hourlyCellId"
    let dailyCellId = "dailyCellId"
    
    // VARIABLE
    var unit : Unit = .metric
    var dateLabelHelper : DateLabelHelper?
    var lastLocation : CLLocationCoordinate2D?
    var lastUpdate : Date?
    var lastForecast : ForecastModel?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAllView()
        setupLocationManager()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yy, h.mma"
        dateLabelHelper = DateLabelHelper.init(dateLabel, formatter: formatter, updateInterval: 2)
        dateLabelHelper?.fire()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let topInset = self.view.frame.height - self.view.safeAreaInsets.bottom - firstCellHeight
        self.tableOfContent.contentInset = UIEdgeInsets.init(top: topInset, left: 0, bottom: self.view.safeAreaInsets.bottom, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateLabelHelper?.fire()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dateLabelHelper?.stop()
    }
    
    // SELECTOR
    
    @objc func onDrawerClick(_ sender : UIBarButtonItem){
        
    }
    
    @objc func onSearchClick(_ sender : UIBarButtonItem){
        
    }
    
    // TABLEVIEW DATASOURCE & DELEGATE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastForecast?.hourly?.data != nil ? (lastForecast?.daily?.data != nil ? lastForecast!.daily!.data!.count + 1 : 1) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: hourlyCellId, for: indexPath) as! HourlyForecastTableCell
            if let data : [Weather] = lastForecast?.hourly?.data {
                cell.apply(using: data)
            }
            cell.backgroundColor = .clear
            return cell
        }
        else {
            let index = indexPath.item - 1
            let cell = tableView.dequeueReusableCell(withIdentifier: dailyCellId, for: indexPath) as! DailyForecastTableViewCell
            if let data : [DailyWeather] = lastForecast?.daily?.data, data.count > index {
                cell.apply(using: data[index])
            }
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    //SCROLLVIEW DELEGATE
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxDistance = -(self.view.frame.height - self.view.safeAreaInsets.bottom - firstCellHeight)
        if scrollView.contentOffset.y >= maxDistance {
            var alpha : CGFloat = 0;
            if scrollView.contentOffset.y >= -44 - self.view.safeAreaInsets.top {
                alpha = 1
            }
            else if scrollView.contentOffset.y == maxDistance {
                alpha = 0
            }
            else {
                alpha = 1 - (scrollView.contentOffset.y / maxDistance)
            }
            navigationBar.alpha = 1 - alpha
            blurBackground.alpha = alpha
        }
    }
    
    // METHOD
    
    func setupLocationManager(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
        else{
            weatherApiManager.getForecast(in: defaultLocation, unit: unit, delegate: self)
        }
    }
    
    func setupAllView(){
        let backgrounds = createImageBackground()
        self.background = backgrounds.0
        self.blurBackground = backgrounds.1
        self.loadingView = backgrounds.2
        
        let weatherLabels = createWeatherLabel()
        weatherLabelsContainer = weatherLabels.0
        weatherIcon = weatherLabels.1
        weatherLabel = weatherLabels.2
        temperatureLabel = weatherLabels.3
        cityLabel = weatherLabels.4
        dateLabel = weatherLabels.5
        labelLoadingView = weatherLabels.6
        
        self.tableOfContent = createTableView()
        tableOfContent.register(HourlyForecastTableCell.self, forCellReuseIdentifier: hourlyCellId)
        tableOfContent.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: dailyCellId)
        tableOfContent.delegate = self
        tableOfContent.dataSource = self
        tableOfContent.delegate = self
        
        navigationBar = createNavigationBar(drawer: #selector(onDrawerClick(_:)), search: #selector(onSearchClick(_:)))
        
    }
    
}
