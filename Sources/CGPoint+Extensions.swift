//
//  CGPoint+Extensions.swift
//  AMConstraints
//
//  Created by Abood Mufti on 2018-10-26.
//  Copyright © 2018 abood mufti. All rights reserved.
//

import UIKit


func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}
