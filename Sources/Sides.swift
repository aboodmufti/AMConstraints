//
//  Sides.swift
//  AMConstraints
//
//  Created by Abood Mufti on 2018-10-16.
//  Copyright © 2018 abood mufti. All rights reserved.
//

import Foundation

/// Enum to represent all 4 sides of a `UIView`.
public enum Side {

    /// Represents the top side edge of the view.
    case top,

    /// Represents the bottom side edge of the view.
    bottom,

    /// Represents the left side edge of the view.
    left,

    /// Represents the ride side edge of the view.
    right

}

/// Enum to represent only horizontal sides of a `UIView`.
public enum SideX {

    /// Represents the left side edge of the view.
    case left,

    /// Represents the right side edge of the view.
    right

}

/// Enum to represent only vertical sides of a `UIView`.
public enum SideY {

    /// Represents the top side edge of the view.
    case top,

    /// Represents the bottom side edge of the view.
    bottom

}

/// A struct that contains a top, bottom, left, and right constraints
public struct Sides {

    /// The top constraint.
    public var top    : NSLayoutConstraint?

    /// The bottom constraint.
    public var bottom : NSLayoutConstraint?

    /// The left constraint.
    public var left   : NSLayoutConstraint?

    /// The right constraint.
    public var right  : NSLayoutConstraint?

    /// Initializes the struct with nil constraints.
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

    // MARK: - where Element == Side

    /// equal to: `[Side.top, Side.bottom, Side.left, Side.right]`
    public static let all    : Set<Side> = [.top, .bottom, .left, .right]

    /// equal to: `[Side.top]`
    public static let top    : Set<Side> = [.top]

    /// equal to: `[Side.bottom]`
    public static let bottom : Set<Side> = [.bottom]

    /// equal to: `[Side.left]`
    public static let left   : Set<Side> = [.left]

    /// equal to: `[Side.right]`
    public static let right  : Set<Side> = [.right]
}
