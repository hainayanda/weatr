//
//  TranslucentView.swift
//  weatr
//
//  Created by Nayanda Haberty on 22/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

class TranslucentView: UIView {
    
    var translucentColor: UIColor = UIColor.black.withAlphaComponent(0.18)
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    private var endColor: UIColor = UIColor.clear
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0, y:
            1)
        gradientLayer.colors = [translucentColor.cgColor, endColor.cgColor]
    }
}
