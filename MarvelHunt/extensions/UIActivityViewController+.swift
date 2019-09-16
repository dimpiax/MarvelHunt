//
//  UIActivityViewController+.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

extension UIActivityViewController {
  convenience init(activityItems: [Any]) {
    self.init(activityItems: activityItems, applicationActivities: nil)
  }
}
