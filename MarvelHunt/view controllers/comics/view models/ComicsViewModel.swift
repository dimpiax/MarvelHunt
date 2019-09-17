//
//  ComicsViewModel.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

class ComicsViewModel {
  private let _mainModel: MainModel
  private let _model: ComicsModel
  private let _data: ComicsData
  
  var title: String { return _data.variantDescription }
  var subtitle: String { return _data.title }
  var desc: String { return _data.desc }
  var shareURL: URL? { return _data.issue }
  
  var isPossibleForSharing: Bool { return shareURL != nil }
  
  init(mainModel: MainModel, model: ComicsModel) {
    _mainModel = mainModel
    _model = model
    _data = model.data
  }
}
