//
//  AttributedUILabelViewController.swift
//  UILabelPerformanceImprovementTests
//
//  Created by Yuichi Fujiki on 21/2/20.
//  Copyright © 2020 yfujiki. All rights reserved.
//

import UIKit

class AttributedUILabelViewController: UIViewController, ContentViewControllerProtocol {
    var nilOutText: Bool = false
    var cacheLabel: Bool = false

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.topAnchor.constraint(equalTo: tableView.topAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
        ])

        return tableView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        _ = tableView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
