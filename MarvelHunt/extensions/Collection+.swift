//
//  Collection+.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation

extension Collection {
  var presented: Self? {
    return isEmpty ? nil : self
  }
}
