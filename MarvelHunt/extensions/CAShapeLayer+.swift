//
//  CAShapeLayer+.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import UIKit

extension CAShapeLayer {
  convenience init(path value: UIBezierPath) {
    self.init()
    
    path = value.cgPath
  }
}
