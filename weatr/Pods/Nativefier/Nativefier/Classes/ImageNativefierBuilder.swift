//
//  ImageNativefierBuilder.swift
//  Nativefier
//
//  Created by Nayanda Haberty on 19/08/18.
//

import Foundation
import UIKit

public class ImageNativefierBuilder {
    fileprivate var maxRamCount : Int?
    fileprivate var maxDiskCount : Int?
    fileprivate var fetcher : ((_ key: String) -> UIImage?)?
    fileprivate var delegate : NativefierDelegate?
    fileprivate var maxRetryCount : Int?
    init() {}
    
    public func set(maxRetryCount : Int) -> ImageNativefierBuilder{
        self.maxRetryCount = maxRetryCount
        return self
    }
    
    public func set(delegate : NativefierDelegate) -> ImageNativefierBuilder{
        self.delegate = delegate
        return self
    }
    
    public func set(fetcher : @escaping (_ key: String) -> UIImage?) -> ImageNativefierBuilder{
        self.fetcher = fetcher
        return self
    }
    
    public func set(maxRamCount : Int) -> ImageNativefierBuilder{
        self.maxRamCount = maxRamCount
        return self
    }
    
    public func set(maxDiskCount : Int) -> ImageNativefierBuilder{
        self.maxDiskCount = maxDiskCount
        if maxRamCount == nil {
            maxRamCount = maxDiskCount / 2
        }
        return self
    }
    
    public func build() -> ImageNativefier {
        let nativefier : ImageNativefier = ImageNativefier(maxRamCount: maxRamCount!, maxDiskCount: maxDiskCount!)
        nativefier.fetcher = self.fetcher
        nativefier.delegate = self.delegate
        nativefier.maxRetryCount = self.maxRetryCount ?? 1
        return nativefier
    }
}
