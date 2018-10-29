//
//  Axes.swift
//  AMConstraints
//
//  Created by Abood Mufti on 2018-10-16.
//  Copyright © 2018 abood mufti. All rights reserved.
//

import Foundation

/// Enum to represent both center Axes of a `UIView`.
public enum Axis {

    /// Represents the center X Axis.
    case centerX,

    /// Represents the center Y Axis.
    centerY
}

/// A struct that contains a centerX and centerY constraints.
public struct Axes {

    /// The center X Axis constraint.
    public var centerX: NSLayoutConstraint?

    /// The center Y Axis constraint.
    public var centerY: NSLayoutConstraint?

    /// Initializes the struct with nil constraints.
    public init() { }

    mutating func set(constraint: NSLayoutConstraint, axis: Axis) {
        switch axis {
        case .centerX: centerX = constraint
        case .centerY: centerY = constraint
        }
    }
}

public extension Set where Element == Axis {

    // MARK: - where Element == Axis

    /// equal to: `[Axis.centerX, Axis.centerY]`
    public static let all     : Set<Axis> = [.centerX, .centerY]

    /// equal to: `[Axis.centerX]`
    public static let centerX : Set<Axis> = [.centerX]

    /// equal to: `[Axis.centerY]`
    public static let centerY : Set<Axis> = [.centerY]
}
