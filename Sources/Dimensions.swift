//
//  Dimensions.swift
//  AMConstraints
//
//  Created by Abood Mufti on 2018-10-16.
//  Copyright © 2018 abood mufti. All rights reserved.
//

import Foundation

/// Enum to represent both dimensions of a `UIView`.
public enum Dimension {

    /// Represents the width of the view.
    case width,

    /// Represents the height of the view.
    height
}

/// A struct that contains a width and height constraints
public struct Dimensions {

    /// The width constraint.
    public var width  : NSLayoutConstraint?

    /// The height constraint.
    public var height : NSLayoutConstraint?

    /// Initializes the struct with nil constraints.
    public init() { }

    mutating func set(constraint: NSLayoutConstraint, dimension: Dimension) {
        switch dimension {
        case .width  : width = constraint
        case .height : height = constraint
        }
    }
}

public extension Set where Element == Dimension {

    // MARK: - where Element == Dimension

    /// equal to: `[Dimension.width, Dimension.height]`
    public static let all    : Set<Dimension> = [.width, .height]

    /// equal to: `[Dimension.width]`
    public static let width  : Set<Dimension> = [.width]

    /// equal to: `[Dimension.height]`
    public static let height : Set<Dimension> = [.height]
}
