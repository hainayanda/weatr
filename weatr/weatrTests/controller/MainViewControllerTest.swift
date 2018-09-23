//
//  MainViewControllerTest.swift
//  weatrTests
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit
import XCTest
@testable import weatr

class MainViewControllerTest: XCTestCase, MainViewControllerObserver {
    
    var mainViewController : MainViewController!
    let dGroup : DispatchGroup = DispatchGroup.init()
    
    override func setUp() {
        super.setUp()
        let mainVC = TestableMainViewController()
        mainVC.observer = self
        mainViewController = mainVC
        dGroup.enter()
        _ = mainViewController.view
        dGroup.wait(timeout: DispatchTime.now() + 5)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAllViewLoaded() {
        assert(mainViewController.background != nil)
        assert(mainViewController.blurBackground != nil)
        assert(mainViewController.cityLabel != nil)
        assert(mainViewController.navigationBar != nil)
        assert(mainViewController.tableOfContent != nil)
        assert(mainViewController.temperatureLabel != nil)
        assert(mainViewController.weatherIcon != nil)
        assert(mainViewController.weatherLabel != nil)
        assert(mainViewController.weatherLabelsContainer != nil)
        assert(mainViewController.dateLabel != nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // OBSERVER
    
    func viewDidLoadRun() {
        dGroup.leave()
    }
    
    class TestableMainViewController : MainViewController {
        
        var observer : MainViewControllerObserver?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            observer?.viewDidLoadRun()
        }
        
    }
}

protocol MainViewControllerObserver {
    func viewDidLoadRun()
}
