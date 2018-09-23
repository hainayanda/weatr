//
//  SearchResultTableViewCell.swift
//  weatr
//
//  Created by Nayanda Haberty on 24/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

class SearchResultTableViewCell : UITableViewCell {
    
    var name : UILabel!
    var summary : UILabel!
    var data : GMSAutocompletePrediction?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        assemblyCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func apply(using model : GMSAutocompletePrediction){
        data = model
        name.text = model.attributedPrimaryText.string
        summary.text = model.attributedSecondaryText?.string
    }
    
    func assemblyCell(){
        contentView.backgroundColor = .clear
        name = UILabel()
        name.textColor = .white
        name.font = UIFont.boldSystemFont(ofSize: 18)
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
        
        NSLayoutConstraint.activate([
            name.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18)
            ])
        
        summary = UILabel()
        summary.textColor = .white
        summary.font = UIFont.systemFont(ofSize: 16)
        summary.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(summary)
        
        NSLayoutConstraint.activate([
            summary.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18),
            summary.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 2),
            contentView.bottomAnchor.constraint(equalTo: summary.bottomAnchor, constant: 9)
            ])
    }
}
