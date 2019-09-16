//
//  MainViewController.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

class ComicsCollectionViewController: UICollectionViewController, Modelable {
  var mainModel: MainModel!
  
  private lazy var _viewModel = ComicsCollectionViewModel(mainModel: mainModel)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ComicsCollectionViewModel.setup(collectionView: collectionView)
    ComicsCollectionViewModel.setup(collectionViewLayout: collectionViewLayout)
    collectionView.delegate = self
    collectionView.prefetchDataSource = self
    
    _viewModel.didCompleteLoadImage = {[weak self] indexPath in
      guard let self = self else { return }
      
      self.collectionView.performBatchUpdates({
        self.collectionView.reloadItems(at: [indexPath])
      }, completion: nil)
    }

//    navigationItem.searchController = getSearchController()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch (SegueIdentifier(value: segue), segue.destination, sender) {
    case (.comicsDetail, let vc as ComicsViewController, let data as ComicsData):
      vc.mainModel = mainModel
      vc.model = ComicsModel(data: data, image: _viewModel.getImage(id: data.id))
      
    default: break
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: UIComicsCollectionViewCell.identifier, for: indexPath)
  }
  
  override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard
      let cell = cell as? UIComicsCollectionViewCell,
      let data = _viewModel.getData(indexPath: indexPath)
    else { return }
    
    cell.apply(data: data)
    cell.apply(image: _viewModel.getImage(id: data.id))
    _viewModel.loadImage(indexPath: indexPath)
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let data = _viewModel.getData(indexPath: indexPath) else { return }
    
    performSegue(.comicsDetail, sender: data)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return _viewModel.numberOfItemsInSection
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return _viewModel.numberOfSections
  }
  
  private func getSearchController() -> UISearchController {
    let searchController = UISearchController(searchResultsController: nil)
    let searchBar = searchController.searchBar
    searchBar.tintColor = .white
    searchBar.barTintColor = .white
    
    return searchController
  }
}

extension ComicsCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.bounds.width - collectionView.contentInset.width, height: 200)
  }
}

extension ComicsCollectionViewController: UICollectionViewDataSourcePrefetching {
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    indexPaths.forEach(_viewModel.loadImage(indexPath:))
  }
  
  func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
    indexPaths.forEach(_viewModel.cancelLoadingImage(indexPath:))
  }
}