//
//  ComicsCollectionViewModel.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

class ComicsCollectionViewModel {
  unowned private var _mainModel: MainModel?
  
  private(set) var data: [ComicsData]?
  
  private var _tasks = [ComicsData.Id: URLSessionDataTask]()
  private var _imagesData = [ComicsData.Id: UIImage]()
  
  var didCompleteLoadImage: ((IndexPath) -> Void)?
  
  var numberOfSections: Int {
    return 1
  }
  
  var numberOfItemsInSection: Int {
    return data?.count ?? 0
  }
  
  init(mainModel: MainModel) {
    _mainModel = mainModel
    
    data = [
      .dummy(),
      .dummy(),
      .dummy(),
      .dummy(),
      .dummy(),
      .dummy()
    ]
  }
  
  func getData(indexPath: IndexPath) -> ComicsData? {
    return data?[indexPath.row]
  }
  
  func getImage(id: ComicsData.Id) -> UIImage? {
    return _imagesData[id]
  }
  
  func loadImage(indexPath: IndexPath) {
    guard let data = getData(indexPath: indexPath) else { return }
    let id = data.id
    
    guard _imagesData[id] == nil else { return }
    
    let task = URLSession.shared.dataTask(with: data.thumbnail) { data, response, error in
      // TODO: refactor
      DispatchQueue.main.async {
        self._imagesData[id] = data == nil ? nil : UIImage(data: data!)
        self.didCompleteLoadImage?(indexPath)
      }
    }
    task.resume()
    
    _tasks[id] = task
  }
  
  func cancelLoadingImage(indexPath: IndexPath) {
    guard let data = getData(indexPath: indexPath) else { return }
    
    _tasks[data.id]?.cancel()
  }
  
  static func setup(collectionView: UICollectionView) {
    collectionView.register(cellClass: UIComicsCollectionViewCell.self)
    
    collectionView.contentInset = .init(top: 10, left: 10, bottom: 0, right: 10)
  }
  
  static func setup(collectionViewLayout value: UICollectionViewLayout) {
    guard let value = value as? UICollectionViewFlowLayout else {
      return
    }
    
    value.minimumLineSpacing = 25
  }
}
