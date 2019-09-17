//
//  HuntViewViewModel.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import struct MapKit.CLLocationCoordinate2D

class HuntViewViewModel {
  private let _data: HuntData
  private let _comicsData: ComicsData
  
  var title: String {
    return _comicsData.variantDescription.presented ?? _comicsData.title
  }
  
  var coordinate: CLLocationCoordinate2D {
    return _data.coordinate
  }
  
  init(data: HuntData) {
    _data = data
    _comicsData = data.data
  }
}
