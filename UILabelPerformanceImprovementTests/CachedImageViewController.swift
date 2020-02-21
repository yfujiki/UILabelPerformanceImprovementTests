//
//  CachedImageViewController.swift
//  UILabelPerformanceImprovementTests
//
//  Created by Yuichi Fujiki on 22/2/20.
//  Copyright © 2020 yfujiki. All rights reserved.
//

import UIKit

class CachedImageTableViewCell: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()

        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
    }
}

class CachedImageViewController: UIViewController, ContentViewControllerProtocol {
    // MARK: - ContentViewControllerProtocol
    var nilOutText: Bool = false
    var attributedLabel: Bool = false

    // MARK: - Cache
    private var imageCache = [IndexPath: UIImageView]()

    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(CachedImageTableViewCell.self, forCellReuseIdentifier: "cell")

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

extension CachedImageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 32
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CachedImageTableViewCell else {
            return UITableViewCell()
        }

        if imageCache[indexPath] == nil {
            let image = UIImage(named: "\(indexPath.row)")
            let imageView = UIImageView(image: image)
            imageCache[indexPath] = imageView
        }
        
        let imageView = imageCache[indexPath]!
        cell.contentView.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -16),
        ])

        return cell
    }
}
