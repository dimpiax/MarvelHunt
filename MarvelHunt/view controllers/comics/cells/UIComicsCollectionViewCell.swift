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
  private let _coverImageView: UIImageView = {
    let value = UIImageView()
//    value.alpha = 0.3
    value.contentMode = .scaleAspectFill
//    value.layer.cornerRadius = 12
//    value.clipsToBounds = true
    return value
  }()
  
  private let _titleLabel: UILabel = {
    let value = UILabel()
    value.font = UIFont.systemFont(ofSize: 24, weight: .medium)
    value.backgroundColor = UIColor.white.withAlphaComponent(0.7)
    value.translatesAutoresizingMaskIntoConstraints = false
    return value
  }()
  
  private let _subtitleLabel: UILabel = {
    let value = UILabel()
    value.numberOfLines = 0
    value.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    value.backgroundColor = UIColor.white.withAlphaComponent(0.7)
    value.translatesAutoresizingMaskIntoConstraints = false
    return value
  }()
  
  private let _descriptionLabel: UILabel = {
    let value = UILabel()
    value.numberOfLines = 0
    value.font = UIFont.systemFont(ofSize: 12, weight: .light)
    value.translatesAutoresizingMaskIntoConstraints = false
    return value
  }()
  
  func apply(data: ComicsData) {
    _titleLabel.text = data.variantDescription
    _titleLabel.sizeToFit()
    
    _subtitleLabel.text = data.title
    _descriptionLabel.text = data.desc
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
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
    contentView.layer.mask = shapeLayer
    layer.cornerRadius = 12
    layer.shadowPath = nil
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowRadius = 4
    layer.shadowOpacity = 0.45
    layer.shadowOffset = .init(width: 0, height: 3)
    //    layer.shouldRasterize = true
    //    layer.rasterizationScale = UIScreen.main.nativeScale
    
    backgroundColor = UIColor.light
    
    contentView.addSubview(_coverImageView)
    _coverImageView.frame = bounds
    
    contentView.addSubview(_titleLabel)
    contentView.addSubview(_subtitleLabel)
    contentView.addSubview(_descriptionLabel)
    
    contentView.directionalLayoutMargins = .init(top: 12, leading: 12, bottom: 0, trailing: 12)
    let layoutMargins = contentView.layoutMarginsGuide
    
    NSLayoutConstraint.activate([
      _titleLabel.topAnchor.constraint(equalTo: layoutMargins.topAnchor),
      _titleLabel.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor),
      _titleLabel.rightAnchor.constraint(lessThanOrEqualTo: layoutMargins.rightAnchor),
      
      _subtitleLabel.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 4),
      _subtitleLabel.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor),
      _subtitleLabel.rightAnchor.constraint(equalTo: layoutMargins.rightAnchor),
      
      _descriptionLabel.topAnchor.constraint(equalTo: _subtitleLabel.bottomAnchor, constant: 3),
      _descriptionLabel.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor),
      _descriptionLabel.rightAnchor.constraint(equalTo: layoutMargins.rightAnchor),
    ])
  }
}
