//
//  HuntViewController.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/17/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class HuntViewController: UIViewController {
  var data: HuntData!
  
  private lazy var _viewModel = HuntViewViewModel(data: data)
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    titleLabel.text = _viewModel.title
    mapView.setCenter(_viewModel.coordinate, animated: false)
    mapView.setCamera(.init(lookingAtCenter: _viewModel.coordinate, fromDistance: 2, pitch: 0, heading: 0), animated: false)
  }
  
  @IBAction func didTapCheckIn() {
    let controller = UIAlertController(
      title: "You've Checked!",
      message: "Please standby, you will receive notification in 10 seconds.\n\nThis is not true for now!",
      preferredStyle: .alert)
    
    controller.addAction(.init(title: "Ok", style: .default))
    
    present(controller)
  }
  
  @IBAction func didTapClose() {
    dismiss(animated: true, completion: nil)
  }
}
