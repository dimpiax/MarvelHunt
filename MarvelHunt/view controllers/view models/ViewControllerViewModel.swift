//
//  ViewControllerViewModel.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

struct ViewControllerViewModel {
  let kvStorage: KeyValueStorage
  
  var isIntroPassed: Bool {
    return kvStorage[.isIntroPassed, Bool.self] == true
  }
  
  func setIntroPassed() {
    kvStorage[.isIntroPassed] = true
  }
}
