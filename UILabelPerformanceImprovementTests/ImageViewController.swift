//
//  ImageViewController.swift
//  UILabelPerformanceImprovementTests
//
//  Created by Yuichi Fujiki on 21/2/20.
//  Copyright © 2020 yfujiki. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    var simpleImage: UIImage? {
        didSet {
            simpleImageView.image = simpleImage
        }
    }

    private lazy var simpleImageView: UIImageView = {
        let imageView = UIImageView()

        contentView.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])

        return imageView
    }()
}

class ImageViewController: UIViewController, ContentViewControllerProtocol {
    var nilOutContent: Bool = false
    var attributedLabel: Bool = false

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "cell")

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

extension ImageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 192
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ImageTableViewCell else {
            return UITableViewCell()
        }

        let imageName = "\(indexPath.row + 1)"
        cell.simpleImage = UIImage(named: imageName)

        return cell
    }
}

extension ImageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard nilOutContent else { return }
        guard let cell = cell as? ImageTableViewCell else { return }

        cell.simpleImage = nil
    }
}
