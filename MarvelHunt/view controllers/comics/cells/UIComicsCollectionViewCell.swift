//
//  UIComicsCollectionViewCell.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

class UIComicsCollectionViewCell: UICollectionViewCell, Identifable {
  private let _shadowLayer: CAGradientLayer = {
    let value = CAGradientLayer()
    value.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
    value.startPoint = .init(x: 0, y: 0)
    value.endPoint = .init(x: 0, y: 1)
    return value
  }()
  
  private let _coverImageView: UIImageView = {
    let value = UIImageView()
    value.contentMode = .scaleAspectFill
    return value
  }()
  
  private let _titleLabel: UILabel = {
    let value = UILabel()
    value.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    value.textColor = .white
    value.translatesAutoresizingMaskIntoConstraints = false
    return value
  }()
  
  private let _subtitleLabel: UILabel = {
    let value = UILabel()
    value.numberOfLines = 0
    value.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    value.textColor = .white
    value.translatesAutoresizingMaskIntoConstraints = false
    return value
  }()
  
  private let _huntCollectionView: HuntCollectionView = {
    let value = HuntCollectionView(collectionViewLayout: .init())
    value.translatesAutoresizingMaskIntoConstraints = false
    return value
  }()
  
  func apply(data: ComicsData) {
    _titleLabel.text = data.variantDescription
    _titleLabel.sizeToFit()
    
    _subtitleLabel.text = data.title
    
    // dummy data
    _huntCollectionView.setData([
      .init(id: data.id, data: data, coordinate: .init(latitude: 41.3851, longitude: 2.1734)),
      .init(id: data.id, data: data, coordinate: .init(latitude: 55.6761, longitude: 12.5683)),
    ])
  }
  
  func apply(image: UIImage?) {
    _coverImageView.image = image
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}

extension UIComicsCollectionViewCell {
  private func setup() {
    let cornerRadius: CGFloat = 12
    
    backgroundColor = UIColor.light
    layer.cornerRadius = cornerRadius
    layer.drawShadow(path: nil,
                     color: .gray,
                     offset: .init(width: 0, height: 3),
                     blurRadius: 4,
                     opacity: 0.45)
    
    // mask content view
    contentView.layer.mask = CAShapeLayer(path: .init(roundedRect: bounds, cornerRadius: cornerRadius))
    
    _coverImageView.frame = bounds
    contentView.addSubview(_coverImageView)
    
    _shadowLayer.frame = bounds
    contentView.layer.addSublayer(_shadowLayer)
    
    contentView.addSubview(_titleLabel)
    contentView.addSubview(_subtitleLabel)
    contentView.addSubview(_huntCollectionView)
    
    contentView.directionalLayoutMargins = .init(top: 12, leading: 12, bottom: 8, trailing: 12)
    let layoutMargins = contentView.layoutMarginsGuide
    
    NSLayoutConstraint.activate([
      _titleLabel.topAnchor.constraint(equalTo: layoutMargins.topAnchor),
      _titleLabel.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor),
      _titleLabel.rightAnchor.constraint(lessThanOrEqualTo: layoutMargins.rightAnchor),
      
      _subtitleLabel.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 4),
      _subtitleLabel.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor),
      _subtitleLabel.rightAnchor.constraint(equalTo: layoutMargins.rightAnchor),
      
      _huntCollectionView.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor),
      _huntCollectionView.rightAnchor.constraint(equalTo: layoutMargins.rightAnchor),
      _huntCollectionView.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor),
      _huntCollectionView.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
}
