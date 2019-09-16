//
//  ViewController.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/15/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, Modelable {
  var mainModel: MainModel!
  
  private lazy var _viewModel = ViewControllerViewModel(kvStorage: mainModel.kvStorage)

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    showScreen()
  }
}

private extension MainViewController {
  func showScreen() {
    guard !_viewModel.isIntroPassed else {
      showMainScreen()
      return
    }
    
    // show intro screen
    guard let vc = VCFactory.get(.intro) as? IntroViewController else {
      assertionFailure()
      return
    }
    
    vc.willRemove = {[unowned self] in
      self._viewModel.setIntroPassed()
      self.showMainScreen(presenting: true)
    }
    add(viewController: vc)
  }
  
  func showMainScreen(presenting: Bool = false) {
    guard let vc = VCFactory.get(.mainNav) as? MainNavigationViewController else {
      assertionFailure()
      return
    }
    
    vc.mainModel = mainModel
    
    if presenting {
      present(vc, options: (presentation: .fullScreen, transition: .coverVertical))
    }
    else {
      add(viewController: vc)
    }
  }
}

