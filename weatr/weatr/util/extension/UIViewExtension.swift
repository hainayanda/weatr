//
//  UIViewExtension.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var elevation : CGFloat {
        get {
            return self.layer.shadowOffset.height
        }
        set {
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0.09, height: newValue)
            self.layer.shadowRadius = CGFloat(newValue)
            self.layer.shadowOpacity = 0.24
        }
    }
    
    func round(corners : [UIRectCorner], with radius : CGFloat){
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.masksToBounds = false
        self.layer.mask = mask
    }
}
