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
  unowned private var _mainModel: MainModel
  
  private(set) var data: [ComicsData]?
  
  private var _tasks = [Int: URLSessionDataTask]()
  
  var didCompleteLoadImage: ((IndexPath) -> Void)?
  
  var controllerTitle: String { return "Comics" }
  
  var numberOfSections: Int { return 1 }
  var numberOfItemsInSection: Int {
    return data?.count ?? 0
  }
  
  private(set) var isFirstLoad = true
  
  init(mainModel: MainModel) {
    _mainModel = mainModel
  }
  
  func loadComics(completion: @escaping (Error?) -> Void) {
    do {
      try _mainModel.serverModel.loadComics {[weak self] result in
        guard let self = self else { return }
        
        do {
          let (value, cacheData) = try result.get()
          if let cacheData = cacheData {
            URLCache.shared.store(cacheData: cacheData)
          }
          
          DispatchQueue.main.async {
            self.isFirstLoad = false
            self.data = value
            completion(nil)
          }
        } catch {
          DispatchQueue.main.async {
            completion(error)
          }
        }
      }
        .resume()
    } catch {
      completion(error)
    }
  }
  
  func getData(indexPath: IndexPath) -> ComicsData? {
    return data?[indexPath.row]
  }
  
  func getImage(url: URL) -> UIImage? {
    return _mainModel.imageFetcher.getImage(url: url)
  }
  
  func loadImage(indexPath: IndexPath) {
    guard let data = getData(indexPath: indexPath) else { return }
    let id = data.id
    
    let task = _mainModel.imageFetcher.requestImage(url: data.thumbnail) {[weak self] image in
      guard let self = self else { return }
      
      DispatchQueue.main.async {
        self.didCompleteLoadImage?(indexPath)
      }
    }
    task?.resume()
    
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
