//
//  UIViewController+.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  func add(viewController value: UIViewController) {
    addChild(value)
    value.didMove(toParent: self)
    view.addSubview(value.view)
  }
  
  func remove(viewController value: UIViewController) {
    value.willMove(toParent: nil)
    value.removeFromParent()
    value.view.removeFromSuperview()
  }
  
  func remove() {
    parent?.remove(viewController: self)
  }
}

extension UIViewController {
  func present(_ viewControllerToPresent: UIViewController, options: (presentation: UIModalPresentationStyle, transition: UIModalTransitionStyle), animated flag: Bool = true, completion: (() -> Void)? = nil) {
    viewControllerToPresent.modalPresentationStyle = options.presentation
    viewControllerToPresent.modalTransitionStyle = options.transition
    
    present(viewControllerToPresent, animated: flag, completion: completion)
  }
}
