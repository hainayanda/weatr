//
//  CGSizeExtension.swift
//  weatr
//
//  Created by Nayanda Haberty on 23/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

func >(left: CGSize, right: CGSize) -> Bool {
    let leftVolume = left.height * left.width
    let rightVolume = right.height * right.width
    return leftVolume > rightVolume
}

func <(left: CGSize, right: CGSize) -> Bool {
    let leftVolume = left.height * left.width
    let rightVolume = right.height * right.width
    return leftVolume < rightVolume
}

func >=(left: CGSize, right: CGSize) -> Bool {
    let leftVolume = left.height * left.width
    let rightVolume = right.height * right.width
    return leftVolume >= rightVolume
}

func <=(left: CGSize, right: CGSize) -> Bool {
    let leftVolume = left.height * left.width
    let rightVolume = right.height * right.width
    return leftVolume <= rightVolume
}
