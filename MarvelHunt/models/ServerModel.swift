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
  
  func loadComics(completion: @escaping (Result<([ComicsData], CacheData?), Error>) -> Void) throws -> URLSessionDataTask {
    let request = URLRequest(url: try URLBuilder.getComicsURL())
    return URLSession(configuration: URLSessionConfiguration.default)
      .dataTask(with: request) {[unowned self] data, response, error in
        if let error = error {
          let err = error as NSError
          print(err.code)
          if err.code == -1009, let data = self.loadDataFromCache(request: request) {
            do {
              let result = try JSONDecoder().decode([ComicsData].self, from: data)
              completion(.success((result, nil)))
            } catch {
              URLCache.shared.removeCachedResponse(for: request)
              completion(.failure(error))
            }
            return
          }

          completion(.failure(error))
          return
        }
        
        guard
          let response = response,
          let data = data
        else { return }
        
        do {
          let comicsData = try self.getResults(data: data)
          let result = try JSONDecoder().decode([ComicsData].self, from: comicsData)
          completion(.success((result, CacheData(request: request, response: response, data: comicsData))))
        } catch {
          completion(.failure(error))
        }
      }
  }
  
  func requestImage(with request: URLRequest, completion: @escaping (Result<(UIImage, CacheData), Error>) -> Void) -> URLSessionDataTask {
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    return urlSession.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      // TODO: check response validity
      guard
        let response = response,
        let data = data,
        let image = UIImage(data: data)
      else {
        completion(.failure(AppError.noData))
        return
      }
      
      completion(.success((image, CacheData(request: request, response: response, data: data))))
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
  
  private func loadDataFromCache(request: URLRequest) -> Data? {
    return URLCache.shared.cachedResponse(for: request)?.data
  }
}
