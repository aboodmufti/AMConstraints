//
//  UIView+Constraints.swift
//  AMConstraints
//
//  Created by Abood Mufti on 2018-10-15.
//  Copyright © 2018 abood mufti. All rights reserved.
//

import UIKit

public enum Side {
    case top, bottom, left, right
    public static var allSides: Set<Side> { return [.top, .bottom, .left, .right] }
}

public enum SideX { case left, right }
public enum SideY { case top, bottom }

public enum Dimension {
    case width, height
    public static var allDimensions: Set<Dimension> { return [.width, .height] }
}

public enum Axis {
    case centerX, centerY
    public static var allAxes: Set<Axis> { return [.centerX, .centerY] }
}

public enum Comparator { case equalTo, greaterThan, lessThan }

public struct Sides {
    public var top    : NSLayoutConstraint?
    public var bottom : NSLayoutConstraint?
    public var left   : NSLayoutConstraint?
    public var right  : NSLayoutConstraint?

    init() { }

    mutating func set(constraint: NSLayoutConstraint, side: Side) {
        switch side {
        case .top    : top = constraint
        case .bottom : bottom = constraint
        case .left   : left = constraint
        case .right  : right = constraint
        }
    }
}

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


public extension UIView {

    // MARK: - Sides

    @discardableResult
    public func constrain(side: Side, _ comparator: Comparator = .equalTo, to view: UIView, constant: CGFloat = 0, isSafe: Bool = false) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint

        switch side {
        case .top:
            let anchor = isSafe ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor
            switch comparator {
            case .equalTo     : constraint = topAnchor.constraint(equalTo: anchor, constant: constant)
            case .greaterThan : constraint = topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .lessThan    : constraint = topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            }
        case .bottom:
            let anchor = isSafe ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor
            switch comparator {
            case .equalTo     : constraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
            case .greaterThan : constraint = bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .lessThan    : constraint = bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            }
        case .left:
            let anchor = isSafe ? view.safeAreaLayoutGuide.leftAnchor : view.leftAnchor
            switch comparator {
            case .equalTo     : constraint = leftAnchor.constraint(equalTo: anchor, constant: constant)
            case .greaterThan : constraint = leftAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .lessThan    : constraint = leftAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            }
        case .right:
            let anchor = isSafe ? view.safeAreaLayoutGuide.rightAnchor : view.rightAnchor
            switch comparator {
            case .equalTo     : constraint = rightAnchor.constraint(equalTo: anchor, constant: constant)
            case .greaterThan : constraint = rightAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .lessThan    : constraint = rightAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            }
        }

        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func constrain(sides: Set<Side>, _ comparator: Comparator = .equalTo, to view: UIView, constant: CGFloat = 0, isSafe: Bool = false) -> Sides {
        var constraints = Sides()

        for side in sides {
            let constraint = constrain(side: side, comparator, to: view,  constant: constant, isSafe: isSafe)
            constraints.set(constraint: constraint, side: side)
        }

        return constraints
    }

    @discardableResult
    public func constrain(side: SideY, _ comparator: Comparator = .equalTo, to side2: SideY, of view: UIView, constant: CGFloat = 0, isSafe: Bool = false) -> NSLayoutConstraint {
        let anchor = side == .top ? topAnchor : bottomAnchor
        let anchor2 = view.anchorFor(side: side2, isSafe: isSafe)

        var constraint: NSLayoutConstraint
        switch comparator {
        case .equalTo     : constraint = anchor.constraint(equalTo: anchor2, constant: constant)
        case .greaterThan : constraint = anchor.constraint(greaterThanOrEqualTo: anchor2, constant: constant)
        case .lessThan    : constraint = anchor.constraint(lessThanOrEqualTo: anchor2, constant: constant)
        }

        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func constrain(side: SideY, _ comparator: Comparator = .equalTo, toCenterYof view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let anchor = side == .top ? topAnchor : bottomAnchor

        var constraint: NSLayoutConstraint
        switch comparator {
        case .equalTo     : constraint = anchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        case .greaterThan : constraint = anchor.constraint(greaterThanOrEqualTo: view.centerYAnchor, constant: constant)
        case .lessThan    : constraint = anchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: constant)
        }

        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func constrain(side: SideX, _ comparator: Comparator = .equalTo, to side2: SideX, of view: UIView, constant: CGFloat = 0, isSafe: Bool = false) -> NSLayoutConstraint {
        let anchor = side == .left ? leftAnchor : rightAnchor
        let anchor2 = view.anchorFor(side: side2, isSafe: isSafe)

        var constraint: NSLayoutConstraint
        switch comparator {
        case .equalTo     : constraint = anchor.constraint(equalTo: anchor2, constant: constant)
        case .greaterThan : constraint = anchor.constraint(greaterThanOrEqualTo: anchor2, constant: constant)
        case .lessThan    : constraint = anchor.constraint(lessThanOrEqualTo: anchor2, constant: constant)
        }

        constraint.isActive = true

        return constraint
    }

    @discardableResult
    public func constrain(side: SideX, _ comparator: Comparator = .equalTo, toCenterXof view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let anchor = side == .left ? leftAnchor : rightAnchor

        var constraint: NSLayoutConstraint
        switch comparator {
        case .equalTo     : constraint = anchor.constraint(equalTo: view.centerXAnchor, constant: constant)
        case .greaterThan : constraint = anchor.constraint(greaterThanOrEqualTo: view.centerXAnchor, constant: constant)
        case .lessThan    : constraint = anchor.constraint(lessThanOrEqualTo: view.centerXAnchor, constant: constant)
        }

        constraint.isActive = true
        return constraint
    }

    private func anchorFor(side: SideY, isSafe: Bool) -> NSLayoutYAxisAnchor {
        switch side {
        case .top    : return isSafe ? safeAreaLayoutGuide.topAnchor    : topAnchor
        case .bottom : return isSafe ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor
        }
    }

    private func anchorFor(side: SideX, isSafe: Bool) -> NSLayoutXAxisAnchor {
        switch side {
        case .left  : return isSafe ? safeAreaLayoutGuide.leftAnchor  : leftAnchor
        case .right : return isSafe ? safeAreaLayoutGuide.rightAnchor : rightAnchor
        }
    }


    // MARK: - Dimensions

    @discardableResult
    public func constrain(dimension: Dimension, _ comparator: Comparator = .equalTo, constant: CGFloat) -> NSLayoutConstraint {
        let anchor = dimension == .width ? widthAnchor : heightAnchor
        var constraint: NSLayoutConstraint

        switch comparator {
        case .equalTo     : constraint = anchor.constraint(equalToConstant: constant)
        case .greaterThan : constraint = anchor.constraint(greaterThanOrEqualToConstant: constant)
        case .lessThan    : constraint = anchor.constraint(lessThanOrEqualToConstant: constant)
        }

        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func constrain(dimension: Dimension, _ comparator: Comparator = .equalTo, to dimension2: Dimension? = nil, of view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        let dimension2 = dimension2 ?? dimension
        let anchor = dimension == .width ? widthAnchor : heightAnchor
        let anchor2 = dimension2 == .width ? view.widthAnchor : view.heightAnchor
        var constraint: NSLayoutConstraint

        switch comparator {
        case .equalTo     : constraint = anchor.constraint(equalTo: anchor2, multiplier: multiplier, constant: constant)
        case .greaterThan : constraint = anchor.constraint(greaterThanOrEqualTo: anchor2, multiplier: multiplier, constant: constant)
        case .lessThan    : constraint = anchor.constraint(lessThanOrEqualTo: anchor2, multiplier: multiplier, constant: constant)
        }

        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func constrain(dimensions: Set<Dimension>, _ comparator: Comparator = .equalTo, to view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Dimensions {
        var constraints = Dimensions()

        for dimension in dimensions {
            let constraint = constrain(dimension: dimension, comparator, to: dimension, of: view, multiplier: multiplier, constant: constant)
            constraints.set(constraint: constraint, dimension: dimension)
        }

        return constraints
    }

    // MARK: - Axes
    @discardableResult
    public func constrain(axis: Axis, _ comparator: Comparator = .equalTo, to view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint

        switch comparator {
        case .equalTo:
            if axis == .centerX {
                constraint = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
            } else {
                constraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
            }
        case .greaterThan:
            if axis == .centerX {
                constraint = centerXAnchor.constraint(greaterThanOrEqualTo: view.centerXAnchor, constant: constant)
            } else {
                constraint = centerYAnchor.constraint(greaterThanOrEqualTo: view.centerYAnchor, constant: constant)
            }
        case .lessThan:
            if axis == .centerX {
                constraint = centerXAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor, constant: constant)
            } else {
                constraint = centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: constant)
            }
        }

        constraint.isActive = true
        return constraint
    }


    @discardableResult
    public func constrain(axes: Set<Axis>, _ comparator: Comparator = .equalTo, to view: UIView, constant: CGFloat = 0) -> Axes {
        var constraints = Axes()
        
        for axis in axes {
            let constraint = constrain(axis: axis, comparator, to: view, constant: constant)
            constraints.set(constraint: constraint, axis: axis)
        }

        return constraints
    }

}
