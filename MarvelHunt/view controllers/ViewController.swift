//
//  ViewController.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/15/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Modelable {
  var mainModel: MainModel!

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    showScreen()
  }
}

private extension ViewController {
  func showScreen() {
    let isIntroPassed = mainModel.kvStorage[.isIntroPassed, Bool.self] == true
    
    if isIntroPassed {
      // show navigation
      
    }
    else {
      // show intro screen
      guard let vc = VCFactory.get(.intro) as? IntroViewController else {
        assertionFailure()
        return
      }
      
      vc.didComplete = {[unowned self] in
        vc.remove()
        self.mainModel.kvStorage[.isIntroPassed] = true
      }
      add(viewController: vc)
    }
  }
}

