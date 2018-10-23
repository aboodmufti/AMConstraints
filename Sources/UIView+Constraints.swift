//
//  UIView+Constraints.swift
//  AMConstraints
//
//  Created by Abood Mufti on 2018-10-15.
//  Copyright © 2018 abood mufti. All rights reserved.
//

import UIKit


public extension UIView {

    public typealias Relation = NSLayoutConstraint.Relation

    private func turnOffAutoConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Sides

    @discardableResult
    private func constrain(side: Side, _ relation: Relation = .equal, to view: UIView, constant: CGFloat = 0, isSafe: Bool = false) -> NSLayoutConstraint {
        turnOffAutoConstraints()
        var constraint: NSLayoutConstraint
        let constant = [.bottom, .right].contains(side) ? -constant : constant

        switch side {
        case .top:
            let anchor = isSafe ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor
            switch relation {
            case .equal              : constraint = topAnchor.constraint(equalTo: anchor, constant: constant)
            case .greaterThanOrEqual : constraint = topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .lessThanOrEqual    : constraint = topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            }
        case .bottom:
            let anchor = isSafe ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor
            switch relation {
            case .equal              : constraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
            case .greaterThanOrEqual : constraint = bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .lessThanOrEqual    : constraint = bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            }
        case .left:
            let anchor = isSafe ? view.safeAreaLayoutGuide.leftAnchor : view.leftAnchor
            switch relation {
            case .equal              : constraint = leftAnchor.constraint(equalTo: anchor, constant: constant)
            case .greaterThanOrEqual : constraint = leftAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .lessThanOrEqual    : constraint = leftAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            }
        case .right:
            let anchor = isSafe ? view.safeAreaLayoutGuide.rightAnchor : view.rightAnchor
            switch relation {
            case .equal              : constraint = rightAnchor.constraint(equalTo: anchor, constant: constant)
            case .greaterThanOrEqual : constraint = rightAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .lessThanOrEqual    : constraint = rightAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            }
        }

        constraint.isActive = true
        return constraint
    }

    /// Adds and activates one or more side constraints.
    /// - parameters:
    ///   - sides: One or more `Side` that correspond to the calling view.
    ///   - relation: The relationship between the left side of the constraint and the right side of the constraint. Defaults to `.equal`
    ///   - view: The view to pin the calling view to.
    ///   - constant: The constant offset for the constraint. A positive value moves the given sides towards the center of the given view. Defaults to `0`
    ///   - isSafe: if `true` the `safeAreaLayoutGuide` for the given view is used. Defaults to `false`
    /// - returns: A new `Sides` instance that contains the appropriate constraints.
    @discardableResult
    public func constrain(sides: Set<Side>, _ relation: Relation = .equal, to view: UIView, constant: CGFloat = 0, isSafe: Bool = false) -> Sides {
        turnOffAutoConstraints()
        var constraints = Sides()

        for side in sides {
            let constraint = constrain(side: side, relation, to: view, constant: constant, isSafe: isSafe)
            constraints.set(constraint: constraint, side: side)
        }

        return constraints
    }

    // MARK: Sides Y

    /// Adds and activates a `SideY` (top/bottom) constraint that will be pinned to a `SideY` of the given view.
    ///
    /// The main purpose of this function is for both sides to be different. Example:
    /// ```
    /// view.constrain(side: .top, to: .bottom, of: view2)
    /// ```
    /// OR
    /// ```
    /// view.constrain(side: .bottom, to: .top, of: view2)
    /// ```
    /// - parameters:
    ///   - sides: One or more `Side` that correspond to the calling view.
    ///   - relation: The relationship between the left side of the constraint and the right side of the constraint. Defaults to `.equal`
    ///   - view: The view to pin the calling view to.
    ///   - constant: The constant offset for the constraint. A positive value moves the given sides towards the center of the given view. Defaults to `0`
    ///   - isSafe: if `true` the `safeAreaLayoutGuide` for the given view is used. Defaults to `false`
    /// - returns: The newly created constraint.
    @discardableResult
    public func constrain(side: SideY, _ relation: Relation = .equal, to side2: SideY, of view: UIView, constant: CGFloat = 0, isSafe: Bool = false) -> NSLayoutConstraint {
        turnOffAutoConstraints()
        let anchor = side == .top ? topAnchor : bottomAnchor
        let anchor2 = view.anchorFor(side: side2, isSafe: isSafe)
        let constant = side == .bottom ? -constant : constant

        var constraint: NSLayoutConstraint
        switch relation {
        case .equal              : constraint = anchor.constraint(equalTo: anchor2, constant: constant)
        case .greaterThanOrEqual : constraint = anchor.constraint(greaterThanOrEqualTo: anchor2, constant: constant)
        case .lessThanOrEqual    : constraint = anchor.constraint(lessThanOrEqualTo: anchor2, constant: constant)
        }

        constraint.isActive = true
        return constraint
    }

    /// Adds and activates a `SideY` (top/bottom) constraint that will be
    /// pinned to the horizontal center line (centerY) of the given view.
    ///
    /// - parameters:
    ///   - sides: A `SideY` that corresponds to the calling view.
    ///   - relation: The relationship between the left side of the constraint and the right side of the constraint. Defaults to `.equal`
    ///   - view: The view to pin the calling view to.
    ///   - constant: The constant offset for the constraint. A positive value moves the given sides towards the center of the given view. Defaults to `0`
    /// - returns: The newly created constraint.
    @discardableResult
    public func constrain(side: SideY, _ relation: Relation = .equal, toCenterYof view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        turnOffAutoConstraints()
        let anchor = side == .top ? topAnchor : bottomAnchor

        var constraint: NSLayoutConstraint
        switch relation {
        case .equal              : constraint = anchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        case .greaterThanOrEqual : constraint = anchor.constraint(greaterThanOrEqualTo: view.centerYAnchor, constant: constant)
        case .lessThanOrEqual    : constraint = anchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: constant)
        }

        constraint.isActive = true
        return constraint
    }

    // MARK: Sides X

    /// Adds and activates a `SideX` (left/right) constraint that will be pinned to a `SideX` of the given view.
    ///
    /// The main purpose of this function is for both sides to be different. Example:
    /// ```
    /// view.constrain(side: .left, to: .right, of: view2)
    /// ```
    /// OR
    /// ```
    /// view.constrain(side: .right, to: .left, of: view2)
    /// ```
    /// - parameters:
    ///   - sides: A `SideX` that corresponds to the calling view.
    ///   - relation: The relationship between the left side of the constraint and the right side of the constraint. Defaults to `.equal`
    ///   - view: The view to pin the calling view to.
    ///   - constant: The constant offset for the constraint. A positive value moves the given sides towards the center of the given view. Defaults to `0`
    ///   - isSafe: if `true` the `safeAreaLayoutGuide` for the given view is used. Defaults to `false`
    /// - returns: The newly created constraint.
    @discardableResult
    public func constrain(side: SideX, _ relation: Relation = .equal, to side2: SideX, of view: UIView, constant: CGFloat = 0, isSafe: Bool = false) -> NSLayoutConstraint {
        turnOffAutoConstraints()
        let anchor = side == .left ? leftAnchor : rightAnchor
        let anchor2 = view.anchorFor(side: side2, isSafe: isSafe)
        let constant = side == .right ? -constant : constant

        var constraint: NSLayoutConstraint
        switch relation {
        case .equal              : constraint = anchor.constraint(equalTo: anchor2, constant: constant)
        case .greaterThanOrEqual : constraint = anchor.constraint(greaterThanOrEqualTo: anchor2, constant: constant)
        case .lessThanOrEqual    : constraint = anchor.constraint(lessThanOrEqualTo: anchor2, constant: constant)
        }

        constraint.isActive = true

        return constraint
    }


    /// Adds and activates a `SideX` (left/right) constraint that will be
    /// pinned to the vertical center line (centerX) of the given view.
    ///
    /// - parameters:
    ///   - sides: A `SideX` that corresponds to the calling view.
    ///   - relation: The relationship between the left side of the constraint and the right side of the constraint. Defaults to `.equal`
    ///   - view: The view to pin the calling view to.
    ///   - constant: The constant offset for the constraint. A positive value moves the given sides towards the center of the given view. Defaults to `0`
    /// - returns: The newly created constraint.
    @discardableResult
    public func constrain(side: SideX, _ relation: Relation = .equal, toCenterXof view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        turnOffAutoConstraints()
        let anchor = side == .left ? leftAnchor : rightAnchor

        var constraint: NSLayoutConstraint
        switch relation {
        case .equal              : constraint = anchor.constraint(equalTo: view.centerXAnchor, constant: constant)
        case .greaterThanOrEqual : constraint = anchor.constraint(greaterThanOrEqualTo: view.centerXAnchor, constant: constant)
        case .lessThanOrEqual    : constraint = anchor.constraint(lessThanOrEqualTo: view.centerXAnchor, constant: constant)
        }

        constraint.isActive = true
        return constraint
    }

    // MARK: Side helper functions
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

    /// Adds and activates a `Dimension` (width/height) constraint that is relative to a constant.
    ///
    /// - parameters:
    ///   - dimension: A `Dimension` that corresponds to the calling view.
    ///   - relation: The relationship between the diension and the constant of the constraint. Defaults to `.equal`
    ///   - constant: The constant offset for the constraint.
    /// - returns: The newly created constraint.
    @discardableResult
    public func constrain(dimension: Dimension, _ relation: Relation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        turnOffAutoConstraints()
        let anchor = dimension == .width ? widthAnchor : heightAnchor
        var constraint: NSLayoutConstraint

        switch relation {
        case .equal              : constraint = anchor.constraint(equalToConstant: constant)
        case .greaterThanOrEqual : constraint = anchor.constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqual    : constraint = anchor.constraint(lessThanOrEqualToConstant: constant)
        }

        constraint.isActive = true
        return constraint
    }

    /// Adds and activates a `Dimension` (width/height) constraint that is relative to another given view.
    ///
    /// - parameters:
    ///   - dimension: A `Dimension` that corresponds to the calling view.
    ///   - relation: The relationship between `diension` and `dimension2`. Defaults to `.equal`
    ///   - dimension2: A dimension that corresponds to the given view. If this is is set to `nil` then it will be equal to `diemsnion`. Defaults to `nil`
    ///   - view: The view to which we are constraining the calling view.
    ///   - multiplier: The constant multiplied with `dimension2` of the given view. Defaults to `1`.
    ///   - constant: The constant offset for the constraint. Defaults to `0`
    /// - returns: The newly created constraint.
    @discardableResult
    public func constrain(dimension: Dimension, _ relation: Relation = .equal, to dimension2: Dimension? = nil, of view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        turnOffAutoConstraints()
        let dimension2 = dimension2 ?? dimension
        let anchor = dimension == .width ? widthAnchor : heightAnchor
        let anchor2 = dimension2 == .width ? view.widthAnchor : view.heightAnchor
        var constraint: NSLayoutConstraint

        switch relation {
        case .equal              : constraint = anchor.constraint(equalTo: anchor2, multiplier: multiplier, constant: constant)
        case .greaterThanOrEqual : constraint = anchor.constraint(greaterThanOrEqualTo: anchor2, multiplier: multiplier, constant: constant)
        case .lessThanOrEqual    : constraint = anchor.constraint(lessThanOrEqualTo: anchor2, multiplier: multiplier, constant: constant)
        }

        constraint.isActive = true
        return constraint
    }

    /// Adds and activates one or both `Dimension` (width/height) constraints that are relative to another given view.
    ///
    /// - parameters:
    ///   - dimension: One or both `Dimension`(s) that will be constrained to the given view.
    ///   - relation: The relationship between `diension` and `dimension2`. Defaults to `.equal`
    ///   - view: The view to which we are constraining the calling view.
    ///   - multiplier: The constant multiplied with `dimension` of the given view. Defaults to `1`.
    ///   - constant: The constant offset for the constraint. Defaults to `0`
    /// - returns: A new `Dimensions` instance that contains the appropriate constraints.
    @discardableResult
    public func constrain(dimensions: Set<Dimension>, _ relation: Relation = .equal, to view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Dimensions {
        turnOffAutoConstraints()
        var constraints = Dimensions()

        for dimension in dimensions {
            let constraint = constrain(dimension: dimension, relation, to: dimension, of: view, multiplier: multiplier, constant: constant)
            constraints.set(constraint: constraint, dimension: dimension)
        }

        return constraints
    }

    // MARK: - Axes

    @discardableResult
    private func constrain(axis: Axis, _ relation: Relation = .equal, to view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        turnOffAutoConstraints()
        var constraint: NSLayoutConstraint

        switch relation {
        case .equal:
            if axis == .centerX {
                constraint = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
            } else {
                constraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
            }
        case .greaterThanOrEqual:
            if axis == .centerX {
                constraint = centerXAnchor.constraint(greaterThanOrEqualTo: view.centerXAnchor, constant: constant)
            } else {
                constraint = centerYAnchor.constraint(greaterThanOrEqualTo: view.centerYAnchor, constant: constant)
            }
        case .lessThanOrEqual:
            if axis == .centerX {
                constraint = centerXAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor, constant: constant)
            } else {
                constraint = centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: constant)
            }
        }

        constraint.isActive = true
        return constraint
    }


    /// Adds and activates one or both `Axis` (centerX/centerY) constraints that are relative to another given view.
    ///
    /// - parameters:
    ///   - axes: One or both `Axis` that will be constrained to the given view.
    ///   - relation: The relationship between the given `axes` of the calling
    ///               view and the same `axes` of the given view. Defaults to `.equal`
    ///   - view: The view to which we are constraining the calling view.
    ///   - constant: The constant offset for the constraint. Defaults to `0`
    /// - returns: A new `Axes` instance that contains the appropriate constraints.
    @discardableResult
    public func constrain(axes: Set<Axis>, _ relation: Relation = .equal, to view: UIView, constant: CGFloat = 0) -> Axes {
        turnOffAutoConstraints()
        var constraints = Axes()
        
        for axis in axes {
            let constraint = constrain(axis: axis, relation, to: view, constant: constant)
            constraints.set(constraint: constraint, axis: axis)
        }

        return constraints
    }

    /// constrains the top of the view to the given view's
    /// normalized position.
    ///
    /// ```
    ///         ___________ 0
    ///         |         |
    ///  top    |         |
    ///  ------ |  View   |- 0.5 <-- normalizedPosition
    ///  |    | |         |
    ///  |self| |_________| 1
    /// ```
    /// - Parameters:
    ///     - view: The view to which the "calling view" should be constrained.
    ///     - normalizedPosition: vertical position between 0 (top) and 1 (bottom).
    func constrain(side: Side, view: UIView, at normalizedPosition: CGFloat ) -> NSLayoutConstraint {
        var attribute: NSLayoutConstraint.Attribute
        var attribute2: NSLayoutConstraint.Attribute
        switch side {
        case .bottom:
            attribute = .bottom
            attribute2 = .centerY
        case .top:
            attribute = .top
            attribute2 = .centerY
        case .left:
            attribute = .left
            attribute2 = .centerX
        case .right:
            attribute = .right
            attribute2 = .centerX
        }

        let constraint = NSLayoutConstraint(item: self,
                           attribute: attribute,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: attribute2,
                           multiplier: normalizedPosition*2,
                           constant: 0.0)
        constraint.isActive = true

        return constraint
    }

    /// Constrains the center of the view to be positioned at the given `point`, relative to the given `view`'s center.
    /// - Parameters:
    ///     - point: The point at which the view should be centered.
    ///              The point's coordinate system should be the same as the given view.
    ///     - view: The view to which the calling view should be constrained.
    /// - Returns: An Axes instance that contains the appropriate constraints.
    @discardableResult
    public func constrainCenter(to point: CGPoint, in view: UIView) -> Axes {
        var axes = Axes()
        let relativePoint = point - view.boundsCenter
        axes.centerY = constrain(axes: .centerY, to: view, constant: relativePoint.y).centerY
        axes.centerX = constrain(axes: .centerX, to: view, constant: relativePoint.x).centerX
        return axes
    }

    var boundsCenter: CGPoint { return CGPoint(x: bounds.width/2, y: bounds.height/2) }
}


func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}


/*
 - top to bottom
 - bottom to top
 - left to right
 - right to left
 - width to height
 - height to width
 -
 */
