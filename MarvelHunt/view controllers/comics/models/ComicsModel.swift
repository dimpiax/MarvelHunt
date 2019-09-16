//
//  ComicsModel.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import class UIKit.UIImage

class ComicsModel {
  let data: ComicsData
  
  var image: UIImage?
  
  init(data: ComicsData, image: UIImage? = nil) {
    self.data = data
    self.image = image
  }
}
