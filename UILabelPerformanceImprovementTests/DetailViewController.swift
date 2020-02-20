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
    @IBOutlet weak var attributedLabelSwitch: UISwitch!
    @IBOutlet weak var contentView: UIView!

    @IBAction func nilOutTextSwitchChanged(_ sender: Any) {
        guard let currentChild = children.first as? ContentViewControllerProtocol else { return }
        currentChild.nilOutText = nilOutTextSwitch.isOn
    }

    @IBAction func attributedLabelSwitchChanged(_ sender: Any) {
        guard let currentChild = children.first as? ContentViewControllerProtocol else { return }
        currentChild.attributedLabel = attributedLabelSwitch.isOn
    }

    var detailItem: Screen?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    private func configureView() {
        nilOutTextSwitch.isOn = false
        attributedLabelSwitch.isOn = false

        if let detail = detailItem {
            title = detail.description
        }

        removeCurrentChild()

        guard let viewController = detailItem?.viewControllerClass.init() else { return }

        addContentViewController(viewController)
    }

    private func addContentViewController(_ viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(viewController)
        contentView.addSubview(viewController.view)
        viewController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            viewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    private func removeCurrentChild() {
        guard let currentChild = children.first else { return }

        currentChild.removeFromParent()
        currentChild.view.removeFromSuperview()
    }
}

protocol ContentViewControllerProtocol where Self: UIViewController {
    var nilOutText: Bool { get set }
    var attributedLabel: Bool { get set }
}


