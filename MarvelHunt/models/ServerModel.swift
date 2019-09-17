//
//  ServerModel.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import UIKit

class ServerModel {
  func requestData() {
    
  }
  
  func requestImage(with request: URLRequest, completion: @escaping (Result<(UIImage, CacheData), Error>) -> Void) -> URLSessionDataTask {
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    return urlSession.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      // TODO: check response also
      guard
        let response = response,
        let data = data,
        let image = UIImage(data: data)
      else {
        completion(.failure(NSError()))
        return
      }
      
      completion(.success((image, CacheData(request: request, response: response, data: data))))
    }
  }
}
