//
//  PlaceAPIManagerTest.swift
//  weatrTests
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import XCTest
import GooglePlaces

@testable import weatr

class PlaceAPIManagerTest : XCTestCase {
    
    let defaultLocation = CLLocationCoordinate2D.init(latitude: -6.21462, longitude: 106.84513) //JAKARTA
    
    var apiManager : PlaceAPIManager?
    var predictions : [GMSAutocompletePrediction]?
    var image : UIImage?
    
    override func setUp() {
        super.setUp()
        apiManager = PlaceAPIManager.sharedInstance
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testQuery() {
        apiManager?.getPlaces(by: "Jakarta", callback: { (predictions, _) in
            guard let _ : [GMSAutocompletePrediction] = predictions else {
                assertionFailure("Failed to get prediction")
                return
            }
        })
    }
    
    func testGetImage(){
        apiManager?.getPhoto(of: "Jakarta", onComplete: { (image, _) in
            guard let _ : UIImage = image else {
                assertionFailure("Failed to get image")
                return
            }
        })
    }
}
