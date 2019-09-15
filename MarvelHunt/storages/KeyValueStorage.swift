//
//  KeyValueStorage.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation

class KeyValueStorage {
  static private let _name = "\(KeyValueStorage.self)"
  
  private let storage = UserDefaults(suiteName: KeyValueStorage._name)!
  
  subscript(value: Key) -> Any? {
    get {
      return storage.object(forKey: value.rawValue)
    }
    set {
      storage.set(newValue, forKey: value.rawValue)
    }
  }
  
  subscript<T>(value: Key, as: T.Type) -> T? {
    get {
      return self[value] as? T
    }
    set {
      self[value] = newValue
    }
  }
  
  func clear() {
    storage.removePersistentDomain(forName: KeyValueStorage._name)
  }
}

extension KeyValueStorage {
  enum Key: String {
    case isIntroPassed
  }
}
