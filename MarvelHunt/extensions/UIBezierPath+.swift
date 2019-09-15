//
//  UIBezierPath+.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/15/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import class UIKit.UIBezierPath
import struct UIKit.CGPoint
import struct UIKit.CGFloat

extension UIBezierPath {
  convenience init(arcCenter: CGPoint, radius: CGFloat) {
    self.init(arcCenter: arcCenter, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: false)
  }
}

