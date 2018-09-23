//
//  CityPictureAPIManager.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import GooglePlaces

class PlaceAPIManager {
    
    public static var sharedInstance = PlaceAPIManager()
    
    //google place API
    private let API_KEY = "AIzaSyBc6mgzOcT_m_dlI8iEWRUagevgJIjQs70"
    
    public var client : GMSPlacesClient
    
    init() {
        GMSPlacesClient.provideAPIKey(API_KEY)
        client = GMSPlacesClient.shared()
    }
    
    func getPlaces(by key : String, callback: @escaping GMSAutocompletePredictionsCallback){
        client.autocompleteQuery(key, bounds: nil, boundsMode: .bias, filter: nil, callback: callback)
    }
    
    func getPhoto(of key : String, onComplete : @escaping (UIImage?, Error?) -> Void) {
        getPlaces(by: key) { (predictions, e) in
            guard let predictions : [GMSAutocompletePrediction] = predictions, predictions.count > 0, let id : String = predictions.first?.placeID else {
                onComplete(nil, e)
                return
            }
            
            self.client.lookUpPhotos(forPlaceID: id, callback: { (placeMetadataList, e) in
                guard let placeMetadataList : [GMSPlacePhotoMetadata] = placeMetadataList?.results, placeMetadataList.count > 0 else {
                    onComplete(nil, e)
                    return
                }
                var choosenMetaData : GMSPlacePhotoMetadata?
                for metaData in placeMetadataList {
                    if let cMetaData : GMSPlacePhotoMetadata = choosenMetaData {
                        if cMetaData.maxSize < metaData.maxSize {
                            choosenMetaData = metaData
                        }
                    }
                    else {
                        choosenMetaData = metaData
                    }
                    
                }
                self.client.loadPlacePhoto(choosenMetaData!, callback: onComplete)
            })
        }
    }
    
}
