//
//  Modelable.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation

protocol Modelable {
  var mainModel: MainModel! { get nonmutating set }
}
