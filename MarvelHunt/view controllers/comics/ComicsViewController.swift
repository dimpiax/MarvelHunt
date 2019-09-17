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
    
    setupShareButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.preTopViewController?.title = ""
    navigationItem.title = _viewModel.title.presented ?? _viewModel.subtitle
    
    mainModel.imageFetcher.requestImage(url: model.data.thumbnail) {[weak self] image in
      guard let self = self else { return }
      
      DispatchQueue.main.async {
        self.imageView.image = image
      }
    }?
      .resume()
    
    titleLabel.text = _viewModel.title
    subtitleLabel.text = _viewModel.subtitle
    descTextView.text = _viewModel.desc
  }
}

private extension ComicsViewController {
  func setupShareButton() {
    guard _viewModel.isPossibleForSharing else { return }
    
    navigationItem.rightBarButtonItem = .init(
      barButtonSystemItem: .action,
      target: self,
      action: #selector(didTapActionButton(_:)))
  }
}

private extension ComicsViewController {
  @IBAction func didTapButton() {
    let controller = UIAlertController(
      title: "You've hidden the magazine!",
      message: "Be notified of founding your spot, and follow instructions.",
      preferredStyle: .alert)
    
    controller.addAction(.init(title: "Ok", style: .default))
    
    present(controller)
  }
}
  
@objc private extension ComicsViewController {
  func didTapActionButton(_ value: UIBarButtonItem) {
    guard let url = _viewModel.shareURL else {
      assertionFailure("Share URL must be presented in this action")
      return
    }
    
    present(UIActivityViewController(activityItems: [url]))
  }
}
