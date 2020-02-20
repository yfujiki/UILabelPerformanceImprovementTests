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

    @IBAction func nilOutTextSwitchChanged(_ sender: Any) {
        guard let currentChild = children.first as? ContentViewControllerProtocol else { return }
        currentChild.nilOutText = nilOutTextSwitch.isOn
    }

    @IBAction func cacheLabelSwitchChanged(_ sender: Any) {
        guard let currentChild = children.first as? ContentViewControllerProtocol else { return }
        currentChild.cacheLabel = cacheLabelSwitch.isOn
    }

    var detailItem: Screen?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    private func configureView() {
        nilOutTextSwitch.isOn = false
        cacheLabelSwitch.isOn = false

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

protocol ContentViewControllerProtocol where Self: UIViewController {
    var nilOutText: Bool { get set }
    var cacheLabel: Bool { get set }
}


