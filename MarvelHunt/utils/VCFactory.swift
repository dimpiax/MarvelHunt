//
//  VCFactory.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

struct VCFactory {
  static func get(_ value: VCIdentifier, bundleId: BundleIdentifier? = nil) -> UIViewController? {
    return value.controller(bundleId: bundleId)
  }
}

extension VCFactory {
  enum VCIdentifier: String {
    case
      intro = "IntroViewController"
    
    case
      main = "MainViewController",
      mainNav = "MainNavigationViewController"
    
    case
      hunt = "HuntViewController"
    
    var storyboardId: String {
      switch self {
      case .intro:
        return "Intro"
        
      case .mainNav, .main:
        return "Main"
        
      case .hunt:
        return "Hunt"
      }
    }
    
    func storyboard(bundleId: BundleIdentifier?) -> UIStoryboard {
      return .init(name: storyboardId, bundle: bundleId?.value)
    }
    
    func controller(bundleId: BundleIdentifier?) -> UIViewController? {
      return storyboard(bundleId: bundleId).instantiateViewController(withIdentifier: rawValue)
    }
  }
  
  enum BundleIdentifier: String {
    case
      main = "com.dimpiax.MarvelHunt"
    
    var value: Bundle? {
      return Bundle(identifier: rawValue)
    }
  }
}
