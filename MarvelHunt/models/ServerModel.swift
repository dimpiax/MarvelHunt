//
//  ServerModel.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import UIKit

class ServerModel {
  typealias JSON = [AnyHashable: Any]
  
  func loadComics(completion: @escaping (Result<[ComicsData], Error>) -> Void) throws -> URLSessionDataTask {
    let request = URLRequest(url: try URLBuilder.getComicsURL(), cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5)
    
    return URLSession(configuration: URLSessionConfiguration.default)
      .dataTask(with: request) {[unowned self] data, response, error in
        guard
          let data = data
        else { return }
        
        do {
          let comicsData = try self.getResults(data: data)
          
          let result = try JSONDecoder().decode([ComicsData].self, from: comicsData)
          completion(.success(result))
        } catch {
          completion(.failure(error))
        }
      }
  }
  
  func requestImage(with url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> URLSessionDataTask {
    let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5)
    
    return URLSession(configuration: URLSessionConfiguration.default)
      .dataTask(with: request) { data, response, error in
        if let error = error {
          completion(.failure(error))
          return
        }
        
        guard
          let data = data,
          let image = UIImage(data: data)
        else {
          completion(.failure(AppError.noData))
          return
        }
        
        completion(.success(image))
      }
  }
  
  private func getResults(data: Data) throws -> Data {
    guard
      let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON,
      let results = (json["data"] as? JSON)?["results"]
    else {
      throw AppError.noData
    }
  
    return try JSONSerialization.data(withJSONObject: results, options: [])
  }
}
