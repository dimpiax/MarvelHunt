//
//  CALayer+.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/15/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import UIKit

extension CALayer {
  func add(_ value: CAPropertyAnimation, delegate: CAAnimationDelegate) {
    value.delegate = delegate
    add(value)
  }
  
  func add(_ value: CAPropertyAnimation) {
    add(value, forKey: value.keyPath)
  }
}

extension CALayer {
  func drawShadow(path: UIBezierPath? = nil, color: UIColor = .black, offset: CGSize = .zero, blurRadius: CGFloat = 2, opacity: Float = 1) {
    setShadow(path: path, color: color, offset: offset, blurRadius: blurRadius, opacity: opacity)
  }
  
  private func setShadow(path: UIBezierPath?, color: UIColor? = .black, offset: CGSize = .zero, blurRadius: CGFloat = 2, opacity: Float = 1) {
    shadowPath = path?.cgPath
    shadowColor = color?.cgColor
    shadowOffset = offset
    shadowRadius = blurRadius
    shadowOpacity = opacity
  }
}
