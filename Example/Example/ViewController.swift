//
//  ViewController.swift
//  Example
//
//  Created by Yuya Oka on 2021/08/09.
//

import MultipleImageView
import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var multipleImageView: MultipleImageView! {
        didSet {
            multipleImageView.layer.cornerRadius = 20
            multipleImageView.layer.masksToBounds = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
