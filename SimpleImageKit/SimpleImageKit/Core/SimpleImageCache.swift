//
//  ImageCache.swift
//  SimpleImageKit
//
//  Created by 한병호 on 2018. 3. 19..
//  Copyright © 2018년 한병호. All rights reserved.
//

import UIKit

public enum SimpleCacheType {
    case all
    case memory
    case disk
    case none
    
    public var cached: Bool {
        switch self {
        case .memory, .disk, .all: return true
        case .none: return false
        }
    }
}

open class SimpleImageCache {
    private let memoryCache = NSCache<NSString, AnyObject>()
}

