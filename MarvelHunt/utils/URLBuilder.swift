//
//  URLBuilder.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation

struct URLBuilder {
  enum Remote: String {
    case comics = "https://gateway.marvel.com/v1/public/comics"
    
    var url: URL {
      return URL(string: rawValue)!
    }
  }
  
  static func getComicsURL() throws -> URL {
    guard
      var components = URLComponents(url: Remote.comics.url, resolvingAgainstBaseURL: false)
      else {
        throw AppError.invalidURL
    }
    
    let timestampString = "(Date().timeIntervalSince1970)"
    let hash = try Credentials.getHash(prefix: timestampString)
    components.queryItems = [
      .init(name: "ts", value: timestampString),
      .init(name: "apikey", value: Credentials.publicKey),
      .init(name: "hash", value: hash),
    ]
    
    guard let url = components.url else { throw AppError.invalidURL }
    return url
  }
}
