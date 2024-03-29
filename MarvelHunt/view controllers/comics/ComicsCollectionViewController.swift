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
  
  private let _activityView = UIActivityIndicatorView(style: .gray)
  
  private lazy var _viewModel = ComicsCollectionViewModel(mainModel: mainModel)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = _viewModel.controllerTitle
    
    ComicsCollectionViewModel.setup(collectionView: collectionView)
    ComicsCollectionViewModel.setup(collectionViewLayout: collectionViewLayout)
    collectionView.delegate = self
    collectionView.prefetchDataSource = self
    
    view.addSubview(_activityView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    _activityView.frame = view.bounds
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    NotificationCenter.default.addObserver(self, selector: #selector(willShowHuntLocation(_:)), name: .willShowHuntLocation, object: nil)
    
    guard _viewModel.isFirstLoad else { return }
    
    _activityView.startAnimating()
    _viewModel.loadComics {[weak self] error in
      guard let self = self else { return }
      
      self._activityView.stopAnimating()
      
      if let _ = error {
        self.present(UIAlertController.getErrorAlertController())
        return
      }
      
      self.collectionView.reloadData()
    }
  }
  
  @objc private func willShowHuntLocation(_ notification: Notification) {
    guard let data = notification.object as? HuntData else {
      assertionFailure("data must be HuntLocation data-type")
      return
    }
    
    guard let vc = VCFactory.get(.hunt) as? HuntViewController else { return }
    vc.data = data
    present(vc, options: (.overFullScreen, .coverVertical))
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    NotificationCenter.default.removeObserver(self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch (SegueIdentifier(value: segue), segue.destination, sender) {
    case (.comicsDetail, let vc as ComicsViewController, let data as ComicsData):
      vc.mainModel = mainModel
      vc.model = ComicsModel(data: data)
      
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
    
    cell.imageFetcher = mainModel.imageFetcher
    cell.apply(data: data)
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
