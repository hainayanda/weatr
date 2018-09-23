//
//  HourlyForecastCell.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

class HourlyForecastTableCell : UITableViewCell, UICollectionViewDataSource {
    
    let cellId = "hourlyCell"
    
    var blurLayer : UIVisualEffectView!
    var collectionView : UICollectionView!
    
    var data : [Weather]?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        assemblyCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        blurLayer.layer.cornerRadius = 18
        blurLayer.clipsToBounds = true
    }
    
    func apply(using models : [Weather]){
        data = models
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if data?.count ?? 0 > 23 {
            return 23
        }
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HourlyForecastCollectionCell
        if indexPath.item < data?.count ?? 0, let model : Weather = data![indexPath.item] {
            cell.apply(using: model)
        }
        return cell
    }
    
    func assemblyCell(){
        contentView.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect.init(style: .dark)
        blurLayer = UIVisualEffectView.init(effect: blurEffect)
        blurLayer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(blurLayer)
        
        NSLayoutConstraint.activate([
            blurLayer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            contentView.bottomAnchor.constraint(equalTo: blurLayer.bottomAnchor, constant: 18),
            blurLayer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18),
            contentView.rightAnchor.constraint(equalTo: blurLayer.rightAnchor, constant : 18)
            ])
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize.init(width: 72, height: 72)
        layout.minimumInteritemSpacing = 9
        layout.minimumLineSpacing = 9
        let collectionView = UICollectionView.init(frame: blurLayer.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(HourlyForecastCollectionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            contentView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 18),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18),
            contentView.rightAnchor.constraint(equalTo: collectionView.rightAnchor, constant : 18)
            ])
        
        collectionView.dataSource = self
        self.collectionView = collectionView
        
        
    }
}
