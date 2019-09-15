//
//  IntroViewController.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/15/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

class IntroViewController: UIViewController {
  var didComplete: (() -> Void)?
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var label: UILabel! {
    didSet {
      label.textColor = .white
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let shapeLayer = CAShapeLayer()
    view.layer.insertSublayer(shapeLayer, at: 0)
    
    shapeLayer.fillColor = UIColor.brand.cgColor
    shapeLayer.add(CABasicAnimation(
      keyPath: #keyPath(CAShapeLayer.path),
      delay: 2, duration: 0.7,
      fromValue: UIBezierPath(arcCenter: imageView.center, radius: 1).cgPath,
      toValue: UIBezierPath(arcCenter: label.center, radius: view.bounds.height).cgPath,
      timingFunction: .init(name: .easeOut)))
    
    label.layer.add(CABasicAnimation(
      keyPath: "position.y",
      delay: 2.1, duration: 0.3,
      fromValue: nil, toValue: imageView.layer.frame.maxY + label.layer.bounds.midY,
      timingFunction: .init(name: .easeOut)))
    
    imageView.layer.add(CABasicAnimation(
      keyPath: "position.x",
      delay: 3, duration: 0.3,
      fromValue: nil, toValue: view.bounds.width * 2,
      timingFunction: .init(name: .easeIn)))
    
    label.layer.add(
      CABasicAnimation(
        keyPath: "position.x",
        delay: 3, duration: 0.3,
        fromValue: nil, toValue: -view.bounds.width * 2,
        timingFunction: .init(name: .easeIn)),
      delegate: self
    )
  }
}

extension IntroViewController: CAAnimationDelegate {
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    didComplete?()
  }
}
