//
//  UIAlertController+.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import UIKit

extension UIAlertController {
  static func getErrorAlertController() -> UIAlertController {
    // INFO: potential palce for localization
    let controller = UIAlertController(title: "Error", message: "Something gone wrong, please, try later", preferredStyle: .alert)
    controller.addAction(.init(title: "Ok", style: .default, handler: nil))
    return controller
  }
}
