//
//  SearchViewController.swift
//  weatr
//
//  Created by Nayanda Haberty on 24/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

class SearchViewController : UITableViewController, UISearchResultsUpdating {
    
    var searchController: UISearchController!
    
    let cellId = "searchResultCell"
    
    var placeApiManager = PlaceAPIManager.sharedInstance
    var predictions : [GMSAutocompletePrediction]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            return
        }
        if let key : String = searchController.searchBar.text, key != "" {
            placeApiManager.getPlaces(by: key) { (predictions, _) in
                if let predictions : [GMSAutocompletePrediction] = predictions {
                    self.predictions = predictions
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! SearchResultTableViewCell
        if let id : String = cell.data?.placeID {
            let presenter = self.presentingViewController as! MainViewController
            dismiss(animated: true) {
                presenter.loadByPlaceId(placeId: id)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchResultTableViewCell
        if let predictions : [GMSAutocompletePrediction] = predictions, predictions.count > indexPath.item {
            let prediction = predictions[indexPath.item]
            cell.apply(using: prediction)
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions?.count ?? 0
    }
    
    func setupView(){
        self.view.backgroundColor = .clear
        let blurEffect = UIBlurEffect.init(style: .dark)
        let blurLayer = UIVisualEffectView.init(effect: blurEffect)
        blurLayer.frame = self.tableView.bounds
        
        searchController = UISearchController.init(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = .white
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.backgroundColor = .clear
        searchController.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.backgroundView = blurLayer
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.5)
        tableView.tableHeaderView = searchController.searchBar
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        definesPresentationContext = true
    }
    
}
