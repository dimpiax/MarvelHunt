//
//  MainNavigationViewController.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationViewController: UINavigationController, Modelable {
  var mainModel: MainModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    (topViewController as? Modelable)?.mainModel = mainModel
  }
}

