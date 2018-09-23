//
//  UIViewControllerExtension.swift
//  weatr
//
//  Created by Nayanda Haberty on 24/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func showAlert(title: String, message: String) -> Void{
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.view.backgroundColor = UIColor.white
            alertController.view.layer.cornerRadius = 18
            let blurEffect = UIBlurEffect.init(style: .regular)
            let blurLayer = UIVisualEffectView.init(effect: blurEffect)
            blurLayer.frame = self.view.bounds
            self.view.addSubview(blurLayer)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: {
                _ in
                blurLayer.removeFromSuperview()
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    public func showOptions(title: String, message: String, options: [UIAlertAction]) -> Void{
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            alertController.view.backgroundColor = UIColor.white
            alertController.view.layer.cornerRadius = 18
            for option in options{
                alertController.addAction(option)
            }
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
