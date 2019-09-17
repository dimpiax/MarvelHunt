//
//  URLCache+.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import UIKit

extension URLCache {
  func store(cacheData value: CacheData) {
    storeCachedResponse(.init(response: value.response, data: value.data), for: value.request)
  }
}
