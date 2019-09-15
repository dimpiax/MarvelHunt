//
//  ViewControllerTests.swift
//  MarvelHuntTests
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import XCTest
@testable import MarvelHunt

class ViewControllerTests: XCTestCase {
  func testConsistency() {
    _ = VCFactory.get(.intro)
    _ = VCFactory.get(.main)
  }
}
