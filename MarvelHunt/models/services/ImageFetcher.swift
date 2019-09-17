//
//  ImageFetcher.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

class ImageFetcher {
  private let _serverModel: ServerModel
  
  init(serverModel: ServerModel) {
    _serverModel = serverModel
  }
  
  func requestImage(url: URL, completion: @escaping (UIImage) -> Void) -> URLSessionDataTask? {
    let task = _serverModel.requestImage(with: url) { result in
      guard let image = try? result.get() else { return }
      
      completion(image)
    }
    
    return task
  }
}

