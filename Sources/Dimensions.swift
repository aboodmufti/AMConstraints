//
//  Dimensions.swift
//  AMConstraints
//
//  Created by Abood Mufti on 2018-10-16.
//  Copyright © 2018 abood mufti. All rights reserved.
//

import Foundation

public enum Dimension { case width, height }

public struct Dimensions {
    public var width  : NSLayoutConstraint?
    public var height : NSLayoutConstraint?

    init() { }

    mutating func set(constraint: NSLayoutConstraint, dimension: Dimension) {
        switch dimension {
        case .width  : width = constraint
        case .height : height = constraint
        }
    }
}

public extension Set where Element == Dimension {
    public static let all    : Set<Dimension> = [.width, .height]
    public static let width  : Set<Dimension> = [.width]
    public static let height : Set<Dimension> = [.height]
}
