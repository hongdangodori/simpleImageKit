//
//  ImageCache.swift
//  SimpleImageKit
//
//  Created by 한병호 on 2018. 3. 19..
//  Copyright © 2018년 한병호. All rights reserved.
//

import Foundation

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
    
    open var maxMemoryCost: UInt = 0 {
        didSet {
            self.memoryCache.totalCostLimit = Int(maxMemoryCost)
        }
    }
    
    //Disk
    fileprivate let ioQueue: DispatchQueue
    fileprivate var fileManager: FileManager!
    
    ///The disk cache location.
    open let diskCachePath: String
    
    /// The default file extension appended to cached files.
    open var pathExtension: String?
    
    /// The longest time duration in second of the cache being stored in disk.
    /// Default is 1 week (60 * 60 * 24 * 7 seconds).
    /// Setting this to a negative value will make the disk cache never expiring.
    open var maxCachePeriodInSecond: TimeInterval = 60 * 60 * 24 * 7 //Cache exists for 1 week
    
    /// The largest disk size can be taken for the cache. It is the total
    /// allocated size of cached files in bytes.
    /// Default is no limit.
    open var maxDiskCacheSize: UInt = 0
    
    fileprivate let processQueue: DispatchQueue
    
    /// The default cache.
    public static let `default` = SimpleImageCache(name: "default")
    
    /// Closure that defines the disk cache path from a given path and cacheName.
    public typealias DiskCachePathClosure = (String?, String) -> String
    
    /// The default DiskCachePathClosure
    public final class func defaultDiskCachePathClosure(path: String?, cacheName: String) -> String {
        let dstPath = path ?? NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        return (dstPath as NSString).appendingPathComponent(cacheName)
    }
    
    /**
     Init method. Passing a name for the cache. It represents a cache folder in the memory and disk.
     
     - parameter name: Name of the cache. It will be used as the memory cache name and the disk cache folder name
     appending to the cache path. This value should not be an empty string.
     - parameter path: Optional - Location of cache path on disk. If `nil` is passed in (the default value),
     the `.cachesDirectory` in of your app will be used.
     - parameter diskCachePathClosure: Closure that takes in an optional initial path string and generates
     the final disk cache path. You could use it to fully customize your cache path.
     
     - returns: The cache object.
     */
    public init(name: String,
                path: String? = nil,
                diskCachePathClosure: DiskCachePathClosure = SimpleImageCache.defaultDiskCachePathClosure)
    {
        
        if name.isEmpty {
            fatalError("[SimpleImageKit] You should specify a name for the cache. A cache with empty name is not permitted.")
        }
        
        let cacheName = "com.chungdan.SimpleImageKit.ImageCache.\(name)"
        memoryCache.name = cacheName
        
        diskCachePath = diskCachePathClosure(path, cacheName)
        
        let ioQueueName = "com.chungdan.SimpleImageKit.ImageCache.ioQueue.\(name)"
        ioQueue = DispatchQueue(label: ioQueueName)
        
        let processQueueName = "com.chungdan.SimpleImageKit.ImageCache.processQueue.\(name)"
        processQueue = DispatchQueue(label: processQueueName, attributes: .concurrent)
        
        ioQueue.sync { fileManager = FileManager() }
    }
}
