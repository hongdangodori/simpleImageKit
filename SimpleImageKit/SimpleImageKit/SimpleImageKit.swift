//
//  SimpleImage.swift
//  SimpleImageKit
//
//  Created by 한병호 on 2018. 3. 19..
//  Copyright © 2018년 한병호. All rights reserved.
//

import UIKit

public final class SimpleImageKit<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

/**
 A type that has Kingfisher extensions.
 */
public protocol SimpleImageCompatible {
    associatedtype CompatibleType
    var kf: CompatibleType { get }
}

public extension SimpleImageCompatible {
    public var sk: SimpleImageKit<Self> {
        get { return SimpleImageKit(self) }
    }
}

//extension Image: SimpleImageCompatible { }
//extension ImageView: SimpleImageCompatible { }
//extension Button: SimpleImageCompatible { }

