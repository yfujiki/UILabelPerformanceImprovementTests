//
//  DetailViewController.swift
//  UILabelPerformanceImprovementTests
//
//  Created by Yuichi Fujiki on 21/2/20.
//  Copyright © 2020 yfujiki. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nilOutContentLabel: UILabel!
    @IBOutlet weak var attributedLabelLabel: UILabel!
    @IBOutlet weak var nilOutContentSwitch: UISwitch!
    @IBOutlet weak var attributedLabelSwitch: UISwitch!
    @IBOutlet weak var contentView: UIView!

    @IBAction func nilOutContentSwitchChanged(_ sender: Any) {
        guard let currentChild = children.first as? ContentViewControllerProtocol else { return }
        currentChild.nilOutContent = nilOutContentSwitch.isOn
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
        nilOutContentSwitch.isOn = false
        attributedLabelSwitch.isOn = false

        if let detail = detailItem {
            title = detail.description

            switch detail {
            case .simple:
                enableSwitch(nilOutContent: true, attributedLabel: true)
            case .cached:
                enableSwitch(nilOutContent: false, attributedLabel: true)
            case .image:
                enableSwitch(nilOutContent: true, attributedLabel: false)
            case .cachedImage:
                enableSwitch(nilOutContent: false, attributedLabel: false)
            }
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

    private func enableSwitch(nilOutContent nilOutContentEnabled: Bool, attributedLabel attributedLabelEnabled: Bool) {
        nilOutContentLabel.alpha = nilOutContentEnabled ? 1.0 : 0.5
        attributedLabelLabel.alpha = attributedLabelEnabled ? 1.0 : 0.5

        nilOutContentSwitch.isEnabled = nilOutContentEnabled
        attributedLabelSwitch.isEnabled = attributedLabelEnabled
    }
}

protocol ContentViewControllerProtocol where Self: UIViewController {
    var nilOutContent: Bool { get set }
    var attributedLabel: Bool { get set }
}


