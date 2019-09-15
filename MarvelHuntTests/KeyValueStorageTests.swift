//
//  KeyValueStorageTests.swift
//  MarvelHuntTests
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import XCTest
@testable import MarvelHunt

class KeyValueStorageTests: XCTestCase {
  private var _storage: KeyValueStorage!
  
  override func setUp() {
    _storage = KeyValueStorage()
    _storage.clear()
  }
  
  override func tearDown() {
    _storage.clear()
  }
  
  func testWriteRead() {
    XCTAssertNil(_storage?[.isIntroPassed, Bool.self])
    
    _storage[.isIntroPassed, Bool.self] = true
    
    XCTAssertTrue(_storage![.isIntroPassed, Bool.self]!)
    XCTAssertEqual(_storage?[.isIntroPassed, Int.self], 1)
    XCTAssertNil(_storage?[.isIntroPassed, String.self])
  }
}
