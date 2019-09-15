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
  
  private lazy var _viewModel = ViewControllerViewModel(kvStorage: mainModel.kvStorage)

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    showScreen()
  }
}

private extension ViewController {
  func showScreen() {
    mainModel.kvStorage.clear()
    if _viewModel.isIntroPassed {
      // show navigation
      
    }
    else {
      // show intro screen
      guard let vc = VCFactory.get(.intro) as? IntroViewController else {
        assertionFailure()
        return
      }
      
      vc.didRemove = {[unowned self] in
        self._viewModel.setIntroPassed()
      }
      add(viewController: vc)
    }
  }
}

