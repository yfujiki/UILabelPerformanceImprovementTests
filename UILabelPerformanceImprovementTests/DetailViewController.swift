//
//  DetailViewController.swift
//  UILabelPerformanceImprovementTests
//
//  Created by Yuichi Fujiki on 21/2/20.
//  Copyright © 2020 yfujiki. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nilOutTextSwitch: UISwitch!
    @IBOutlet weak var cacheLabelSwitch: UISwitch!
    @IBOutlet weak var contentView: UIView!

    var detailItem: Screen?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    private func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            title = detail.description
        }

        removeCurrentChild()

        guard let viewController = detailItem?.viewControllerClass.init() else { return }

        addChild(viewController)
        contentView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }

    private func removeCurrentChild() {
        guard let currentChild = children.first else { return }

        currentChild.removeFromParent()
        currentChild.view.removeFromSuperview()
    }
}

