//
//  CachedUILabelViewController.swift
//  UILabelPerformanceImprovementTests
//
//  Created by Yuichi Fujiki on 21/2/20.
//  Copyright © 2020 yfujiki. All rights reserved.
//

import UIKit

class CachedUILabelTableViewCell: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()

        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
    }
}

class CachedUILabelViewController: UIViewController, ContentViewControllerProtocol {
    // MARK: - ContentViewControllerProtocol
    var nilOutText: Bool = false
    var attributedLabel: Bool = false {
        didSet {
            tableView.reloadData()
            if attributedLabel {
                labelCache.removeAll()
            } else {
                attributedLabelCache.removeAll()
            }
        }
    }

    // MARK: - Cache
    private var labelCache = [IndexPath: UILabel]()
    private var attributedLabelCache = [IndexPath: UILabel]()

    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(CachedUILabelTableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.dataSource = self
//        tableView.delegate = self

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

extension CachedUILabelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CachedUILabelTableViewCell else {
            return UITableViewCell()
        }

        if attributedLabel {
            if attributedLabelCache[indexPath] == nil {
                let label = UILabel()
                label.numberOfLines = 0
                attributedLabelCache[indexPath] = label
            }
            let attributedLabel = attributedLabelCache[indexPath]!
            let attributedString = NSAttributedString(string: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. for \(indexPath)", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.red
            ])
            attributedLabel.attributedText = attributedString

            cell.contentView.addSubview(attributedLabel)

            attributedLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                attributedLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
                attributedLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
                attributedLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 16),
                attributedLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -16),
            ])
        } else {
            if labelCache[indexPath] == nil {
                let label = UILabel()
                label.numberOfLines = 0
                labelCache[indexPath] = label
            }

            let label = labelCache[indexPath]!
            label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. for \(indexPath)"

            cell.contentView.addSubview(label)

            label.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
                label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
                label.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 16),
                label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -16),
            ])
        }

        return cell
    }
}
