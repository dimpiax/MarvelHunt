//
//  Identifable.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation

protocol Identifable {
  static var identifier: String { get }
}

extension Identifable {
  static var identifier: String { return "\(self)" }
}
