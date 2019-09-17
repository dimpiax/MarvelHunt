//
//  ComicsViewController.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation
import UIKit

class ComicsViewController: UIViewController, Modelable {
  var mainModel: MainModel!
  var model: ComicsModel!
  
  private lazy var _viewModel = ComicsViewModel(mainModel: mainModel, model: model)
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var descTextView: UITextView! {
    didSet {
      descTextView.textContainerInset = .zero
      descTextView.textContainer.lineFragmentPadding = 0
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initShareButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.preTopViewController?.title = ""
    navigationItem.title = _viewModel.title.presented ?? _viewModel.subtitle
    
    imageView.image = _viewModel.image
    titleLabel.text = _viewModel.title
    subtitleLabel.text = _viewModel.subtitle
    descTextView.text = _viewModel.desc
  }
  
  private func initShareButton() {
    guard _viewModel.isPossibleForSharing else { return }
    
    navigationItem.rightBarButtonItem = .init(
      barButtonSystemItem: .action,
      target: self,
      action: #selector(didTapActionButton(_:)))
  }
  
  @IBAction func didTapButton() {
    let controller = UIAlertController(
      title: "You've hidden the magazine!",
      message: "Be notified of founding your spot, and follow instructions.",
      preferredStyle: .alert)
    
    controller.addAction(.init(title: "Ok", style: .default))
    
    present(controller)
  }
  
  @objc private func didTapActionButton(_ value: UIBarButtonItem) {
    guard let url = _viewModel.shareURL else {
      assertionFailure("Share URL must be presented in this action")
      return
    }
    
    present(UIActivityViewController(activityItems: [url]))
  }
}
