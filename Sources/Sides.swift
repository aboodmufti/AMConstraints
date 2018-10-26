//
//  Sides.swift
//  AMConstraints
//
//  Created by Abood Mufti on 2018-10-16.
//  Copyright © 2018 abood mufti. All rights reserved.
//

import Foundation

public enum Side { case top, bottom, left, right }
public enum SideX { case left, right }
public enum SideY { case top, bottom }

public struct Sides {
    public var top    : NSLayoutConstraint?
    public var bottom : NSLayoutConstraint?
    public var left   : NSLayoutConstraint?
    public var right  : NSLayoutConstraint?

    public init() { }

    mutating func set(constraint: NSLayoutConstraint, side: Side) {
        switch side {
        case .top    : top = constraint
        case .bottom : bottom = constraint
        case .left   : left = constraint
        case .right  : right = constraint
        }
    }
}

public extension Set where Element == Side {
    public static let all    : Set<Side> = [.top, .bottom, .left, .right]
    public static let top    : Set<Side> = [.top]
    public static let bottom : Set<Side> = [.bottom]
    public static let left   : Set<Side> = [.left]
    public static let right  : Set<Side> = [.right]
}
