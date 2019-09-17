//
//  HuntCollectionView.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

class HuntCollectionView: UICollectionView {
  private var _viewModel = HuntCollectionViewModel()
  
  init(collectionViewLayout layout: UICollectionViewFlowLayout) {
    super.init(frame: .zero, collectionViewLayout: layout)
    
    HuntCollectionViewModel.setup(layout: layout)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setData(_ value: [HuntData]?) {
    _viewModel.setData(value)
    
    reloadData()
  }
}

extension HuntCollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return _viewModel.numberOfItemsInSection
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: UIHuntCollectionViewCell.identifier, for: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard
      let cell = cell as? UIHuntCollectionViewCell,
      let data = _viewModel.getData(indexPath: indexPath)
    else { return }
    
    cell.apply(data: data, index: indexPath.row + 1)
  }
}

extension HuntCollectionView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let data = _viewModel.getData(indexPath: indexPath) else { return }
    
    NotificationCenter.default.post(name: .willShowHuntLocation, object: data)
  }
}

private extension HuntCollectionView {
  func setup() {
    backgroundColor = .clear
    register(cellClass: UIHuntCollectionViewCell.self)
    
    dataSource = self
    delegate = self
  }
}
