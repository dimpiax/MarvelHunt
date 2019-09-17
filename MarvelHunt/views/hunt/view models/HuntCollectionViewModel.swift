//
//  HuntCollectionViewModel.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

class HuntCollectionViewModel {
  private var _data: [HuntData]?
  
  var numberOfSections: Int { return 1 }
  var numberOfItemsInSection: Int {
    return _data?.count ?? 0
  }
  
  func setData(_ value: [HuntData]?) {
    _data = value
  }
  
  func getData(indexPath: IndexPath) -> HuntData? {
    return _data?[indexPath.row]
  }
  
  static func setup(layout: UICollectionViewFlowLayout) {
    layout.itemSize = .init(width: 40, height: 40)
    layout.scrollDirection = .horizontal
    layout.minimumInteritemSpacing = 2
  }
}
