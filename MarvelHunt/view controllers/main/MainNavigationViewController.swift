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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let vc = topViewController as? Modelable else {
      return
    }
    
    vc.mainModel = mainModel
  }
}

