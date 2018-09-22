//
//  MainViewController.swift
//  weatr
//
//  Created by Nayanda Haberty on 22/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

class MainViewController : UIViewController {
    
    weak var background : UIImageView!
    weak var blurBackground : UIVisualEffectView!
    weak var navigationBar : UINavigationBar!
    weak var tableOfContent : UITableView!
    weak var weatherLabelsContainer : UIView!
    weak var weatherIcon : UIImageView!
    weak var weatherLabel : UILabel!
    weak var temperatureLabel : UILabel!
    weak var cityLabel : UILabel!
    
    let firstCellHeight : CGFloat = 120
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgrounds = createImageBackground()
        self.background = backgrounds.0
        self.blurBackground = backgrounds.1
        
        self.tableOfContent = createTableView()
        
        let weatherLabels = createWeatherLabel()
        weatherLabelsContainer = weatherLabels.0
        weatherIcon = weatherLabels.1
        weatherLabel = weatherLabels.2
        temperatureLabel = weatherLabels.3
        cityLabel = weatherLabels.4
        
        navigationBar = createNavigationBar(drawer: #selector(onDrawerClick(_:)), search: #selector(onSearchClick(_:)))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let bottomInset = self.view.safeAreaInsets.bottom
        let topInset = self.view.frame.height - bottomInset - firstCellHeight
        self.tableOfContent.contentInset = UIEdgeInsets.init(top: topInset, left: 9, bottom: bottomInset, right: 9)
    }
    
    // SELECTOR
    
    @objc func onDrawerClick(_ sender : UIBarButtonItem){
        
    }
    
    @objc func onSearchClick(_ sender : UIBarButtonItem){
        
    }
    
}
