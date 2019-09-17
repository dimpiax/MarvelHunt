//
//  Credentials.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

struct Credentials {
  // INFO: keys must be included in .plist by automatic way during specific automation lane
  static var publicKey = "fe72df79060725908ac5e758d88340cd"
  static var privateKey = "3f9df4ff62f6e70b1ef297fad301fd97c2733389"
  
  static func getHash(prefix: String) throws -> String {
    guard let value = Crypto.getMD5(string: "\(prefix)\(privateKey)\(publicKey)") else {
      throw AppError.noData
    }
    
    return value
  }
}
