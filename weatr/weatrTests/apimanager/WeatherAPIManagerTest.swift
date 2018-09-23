//
//  WeatherAPIManagerTest.swift
//  weatrTests
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import XCTest
import Eatr
import CoreLocation

@testable import weatr

class WeatherAPIManagerTest: XCTestCase, EatrDelegate {
    
    let defaultLocation = CLLocationCoordinate2D.init(latitude: -6.21462, longitude: 106.84513) //JAKARTA
    let dGroup : DispatchGroup = DispatchGroup.init()
    
    var apiManager : WeatherAPIManager?
    var model : ForecastModel?
    
    override func setUp() {
        super.setUp()
        apiManager = WeatherAPIManager.sharedInstance
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testForecastRequest() {
        dGroup.enter()
        apiManager?.getForecast(in: defaultLocation, unit: .metric, delegate: self)
        dGroup.wait(timeout: DispatchTime.now() + 30)
        guard let model1 : ForecastModel = model, let metricTemp : Double = model1.currently?.temperature else {
            assertionFailure("Failed to get or parsing data")
            return
        }
        let imperialTempShouldBe = metricTemp * 9 / 5 + 32
        dGroup.enter()
        apiManager?.getForecast(in: defaultLocation, unit: .imperial, delegate: self)
        dGroup.wait(timeout: DispatchTime.now() + 30)
        guard let model2 : ForecastModel = model, let imperialTemp : Double = model2.currently?.temperature else {
            assertionFailure("Failed to get or parsing data")
            return
        }
        let tempRange = abs(imperialTemp - imperialTempShouldBe)
        assert(tempRange < 1)
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func eatrOnBeforeSending(_ sessionToSend: URLSession) -> URLSession {
        model = nil
        return sessionToSend
    }
    
    func eatrOnResponded(_ response: EatrResponse) {
        model = response.parsedBody()
    }
    
    func eatrOnFinished() {
        dGroup.leave()
    }
    
}
