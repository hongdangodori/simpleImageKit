//
//  SimpleImageKit.swift
//  SimpleImageKit
//
//  Created by 한병호 on 2018. 3. 19..
//  Copyright © 2018년 한병호. All rights reserved.
//

import Foundation

public typealias DownloadProgressBlock = ((_ receivedSize: Int64, _ totalSize: Int64) -> Void)
public typealias CompletionHandler = ((_ image: Image?, _ error: NSError?, _ cacheType: SimpleCacheType, _ imageURL: URL?) -> Void)


//public class SimpleImageManager {
//    public static let shared = SimpleImageManager()
//
//    public var cache: ImageCache
//
//    public var downloader: ImageDownloader
//
//
//}

