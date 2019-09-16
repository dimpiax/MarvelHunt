//
//  UINavigationController+.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
  var preTopViewController: UIViewController? {
    let count = viewControllers.count
    guard count > 1 else { return nil }
    return viewControllers[count - 2]
  }
}
