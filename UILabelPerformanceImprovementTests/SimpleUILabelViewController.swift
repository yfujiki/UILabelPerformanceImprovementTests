//
//  SimpleUILabelViewController.swift
//  UILabelPerformanceImprovementTests
//
//  Created by Yuichi Fujiki on 21/2/20.
//  Copyright © 2020 yfujiki. All rights reserved.
//

import UIKit

class SimpleUILabelTableViewCell: UITableViewCell {
    var simpleText: String? {
        didSet {
            simpleTextLabel.text = simpleText
        }
    }

    var attributedText: NSAttributedString? {
        didSet {
            attributedTextLabel.attributedText = attributedText
        }
    }

    private lazy var simpleTextLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0

        contentView.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        return label
    }()

    private lazy var attributedTextLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0

        contentView.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        return label
    }()
}

class SimpleUILabelViewController: UIViewController, ContentViewControllerProtocol {
    // MARK: - ContentViewControllerProtocol
    var nilOutText: Bool = false
    var attributedLabel: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }

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

        if attributedLabel {
            let attributedString = NSAttributedString(string: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. for \(indexPath)", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.red
            ])
            cell.simpleText = nil
            cell.attributedText = attributedString
        } else {
            cell.attributedText = nil
            cell.simpleText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. for \(indexPath)"
        }

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
