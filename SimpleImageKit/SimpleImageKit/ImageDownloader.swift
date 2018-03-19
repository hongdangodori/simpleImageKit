//
//  ImageDownloader.swift
//  SimpleImageKit
//
//  Created by 한병호 on 2018. 3. 19..
//  Copyright © 2018년 한병호. All rights reserved.
//

import Foundation

open class ImageDownloader {
    public static let `default` = ImageDownloader()
    
    // MARK: - Internal property
    let barrierQueue: DispatchQueue
    let processQueue: DispatchQueue
    let cancelQueue: DispatchQueue
}
