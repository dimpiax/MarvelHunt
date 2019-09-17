//
//  UIHuntCollectionViewCell.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

class UIHuntCollectionViewCell: UICollectionViewCell, Identifable {
  private let _titleLabel: UILabel = {
    let value = UILabel()
    value.font = UIFont.systemFont(ofSize: 18, weight: .ultraLight)
    value.textColor = UIColor.darkText.withAlphaComponent(0.5)
    value.textAlignment = .center
    return value
  }()
  
  func apply(data: HuntData, index: Int) {
    _titleLabel.text = "\(index)"
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}

private extension UIHuntCollectionViewCell {
  private func setup() {
    // mask content view
    contentView.layer.mask = CAShapeLayer(path: .init(roundedRect: bounds, cornerRadius: 4))
    contentView.backgroundColor = UIColor.white.withAlphaComponent(0.95)
    
    contentView.addSubview(_titleLabel)
    _titleLabel.frame = contentView.bounds
  }
}
