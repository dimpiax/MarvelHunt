//
//  SegueIdentifier.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import UIKit

enum SegueIdentifier: String {
  case
    comicsDetail
  
  init(value: UIStoryboardSegue) {
    guard let identifier = value.identifier else {
      fatalError("UIStoryboardSegue must be defined")
    }
    
    switch identifier {
    case "comicsDetail": self = .comicsDetail
    default: fatalError("\(identifier) isn't defined")
    }
  }
}
