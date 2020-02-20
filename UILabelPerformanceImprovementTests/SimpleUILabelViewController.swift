//
//  SimpleUILabelViewController.swift
//  UILabelPerformanceImprovementTests
//
//  Created by Yuichi Fujiki on 21/2/20.
//  Copyright © 2020 yfujiki. All rights reserved.
//

import UIKit

class SimpleUILabelTableViewCell: UITableViewCell {
    var simpleText: String? = "" {
        didSet {
            simpleTextLabel.text = simpleText
        }
    }

    private lazy var simpleTextLabel: UILabel = {
        let label = UILabel()

        contentView.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])

        return label
    }()
}

class SimpleUILabelViewController: UIViewController, ContentViewControllerProtocol {
    // MARK: - ContentViewControllerProtocol
    var nilOutText: Bool = false
    var cacheLabel: Bool = false

    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(SimpleUILabelTableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.dataSource = self
        tableView.delegate = self

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

extension SimpleUILabelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SimpleUILabelTableViewCell else {
            return UITableViewCell()
        }

        cell.simpleText = "This is a table view cell for \(indexPath)"

        return cell
    }
}

extension SimpleUILabelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard nilOutText else { return }
        guard let cell = cell as? SimpleUILabelTableViewCell else { return }

        cell.simpleText = nil
    }
}
