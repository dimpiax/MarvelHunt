//
//  CALayer+.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/15/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import class QuartzCore.CALayer
import class QuartzCore.CAPropertyAnimation

extension CALayer {
  func add(_ value: CAPropertyAnimation) {
    add(value, forKey: value.keyPath)
  }
}
