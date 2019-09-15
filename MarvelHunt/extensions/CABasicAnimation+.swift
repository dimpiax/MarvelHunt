//
//  CABasicAnimation+.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/15/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import class QuartzCore.CABasicAnimation
import class QuartzCore.CAMediaTimingFunction
import struct QuartzCore.CFTimeInterval
import func QuartzCore.CACurrentMediaTime

extension CABasicAnimation {
  convenience init(keyPath: String, delay: CFTimeInterval, duration: CFTimeInterval, fromValue: Any?, toValue: Any?, timingFunction: CAMediaTimingFunction? = nil) {
    self.init(keyPath: keyPath)
    
    beginTime = CACurrentMediaTime() + delay
    self.duration = duration
    self.fromValue = fromValue
    self.toValue = toValue
    self.timingFunction = timingFunction
    
    fillMode = .forwards
    isRemovedOnCompletion = false
  }
}
