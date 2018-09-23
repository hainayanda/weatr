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

class MainViewController : UIViewController  {
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
    let defaultLocation = CLLocationCoordinate2D.init(latitude: -6.21462, longitude: 106.84513) //JAKARTA
    let firstCellHeight : CGFloat = 120
    let locationManager = CLLocationManager()
    
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
        formatter.dateFormat = "dd MMM yy, h.mm"
        dateLabelHelper = DateLabelHelper.init(dateLabel, formatter: formatter, updateInterval: 2)
        dateLabelHelper?.fire()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let bottomInset = self.view.safeAreaInsets.bottom
        let topInset = self.view.frame.height - bottomInset - firstCellHeight
        self.tableOfContent.contentInset = UIEdgeInsets.init(top: topInset, left: 9, bottom: bottomInset, right: 9)
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
        
        self.tableOfContent = createTableView()
        
        let weatherLabels = createWeatherLabel()
        weatherLabelsContainer = weatherLabels.0
        weatherIcon = weatherLabels.1
        weatherLabel = weatherLabels.2
        temperatureLabel = weatherLabels.3
        cityLabel = weatherLabels.4
        dateLabel = weatherLabels.5
        labelLoadingView = weatherLabels.6
        
        navigationBar = createNavigationBar(drawer: #selector(onDrawerClick(_:)), search: #selector(onSearchClick(_:)))
        
    }
    
}
