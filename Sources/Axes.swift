//
//  Axes.swift
//  AMConstraints
//
//  Created by Abood Mufti on 2018-10-16.
//  Copyright © 2018 abood mufti. All rights reserved.
//

import Foundation

public enum Axis { case centerX, centerY }

public struct Axes {
    public var centerX: NSLayoutConstraint?
    public var centerY: NSLayoutConstraint?

    init() { }

    mutating func set(constraint: NSLayoutConstraint, axis: Axis) {
        switch axis {
        case .centerX: centerX = constraint
        case .centerY: centerY = constraint
        }
    }
}

public extension Set where Element == Axis {
    public static let all     : Set<Axis> = [.centerX, .centerY]
    public static let centerX : Set<Axis> = [.centerX]
    public static let centerY : Set<Axis> = [.centerY]
}
