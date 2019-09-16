//
//  ComicsViewController.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

class ComicsViewController: UIViewController, Modelable {
  var mainModel: MainModel!
  var model: ComicsModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .action, target: nil, action: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.preTopViewController?.title = ""
    navigationItem.title = model.data.title
    
    // TODO: show or load image
    // set titles
  }
}
