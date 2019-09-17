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
  
  func loadComics(completion: @escaping (Result<[ComicsData], Error>) -> Void) {
    guard var components = URLComponents(url: URL(string: "https://gateway.marvel.com/v1/public/comics")!, resolvingAgainstBaseURL: true) else {
      return
    }
    
    components.queryItems = [
      .init(name: "ts", value: "5"),
      .init(name: "apikey", value: "fe72df79060725908ac5e758d88340cd"),
      .init(name: "hash", value: "bbecd88ac5fc07796ab1a21f97d93286"),
    ]
    
    guard let url = components.url else { return }
    
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    urlSession.dataTask(with: url) { data, response, error in
      guard let data = data else { return }
      
      do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else {
          return
        }
        guard let results = (json["data"] as? JSON)?["results"] else { return }
        let data = try JSONSerialization.data(withJSONObject: results, options: [])
        
        let result = try JSONDecoder().decode([ComicsData].self, from: data)
        print(result.count)
        completion(.success(result))
      } catch {
        completion(.failure(error))
      }
    }
    .resume()
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
