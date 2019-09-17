//
//  MainModel.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation

class MainModel {
  let kvStorage = KeyValueStorage()
  
  let serverModel = ServerModel()
  
  let comicsModel = ComicsCollectionModel()
  
  lazy var imageFetcher = ImageFetcher(serverModel: serverModel)
}
