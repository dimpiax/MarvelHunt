//
//  UICollectionView+.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
  func register<T>(cellClass value: T.Type) where T: UICollectionViewCell & Identifable {
    register(value, forCellWithReuseIdentifier: value.identifier)
  }
}
