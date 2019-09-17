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
  
  func getImage(request: URLRequest) -> UIImage? {
    guard
      let data = URLCache.shared.cachedResponse(for: request)?.data,
      let image = UIImage(data: data)
      else {
        return nil
    }
    
    return image
  }
  
  func getImage(url: URL) -> UIImage? {
    return getImage(request: URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5))
  }
  
  func requestImage(url: URL, completion: @escaping (UIImage) -> Void) -> URLSessionDataTask? {
    let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5)
    if let _ = getImage(request: request) {
      //completion(image)
      return nil
    }
    
    let task = _serverModel.requestImage(with: request) { result in
      guard let (image, cacheData) = try? result.get() else { return }
      
      URLCache.shared.store(cacheData: cacheData)
      
      completion(image)
    }
    
    return task
  }
}

