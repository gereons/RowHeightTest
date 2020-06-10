//
//  ViewController.swift
//  RowHeightTest
//
//  Created by Gereon Steffens on 10.06.20.
//  Copyright © 2020 snabble. All rights reserved.
//

import UIKit
import FlexibleRowHeightGridLayout

class ViewController: UIViewController {

    var items = [String]()

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 1 ... 10 {
            let s = Array(repeating: "Hello", count: i)
            items.append(s.joined(separator: " "))
        }

        let nib = UINib(nibName: "TestCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "cell")

        let layout = FlexibleRowHeightGridLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.delegate = self

        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

extension ViewController: FlexibleRowHeightGridLayoutDelegate {
    func numberOfColumns(for size: CGSize) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout: FlexibleRowHeightGridLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
        guard let nib = Bundle.main.loadNibNamed("TestCell", owner: TestCell.self, options: nil), let cell = nib[0] as? TestCell else {
            return 0
        }

        cell.text = items[indexPath.item]

        cell.contentView.setNeedsLayout()
        cell.contentView.layoutIfNeeded()
        let size = cell.contentView.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize,
            withHorizontalFittingPriority: .defaultHigh,
            verticalFittingPriority: .defaultLow)

        return size.height
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TestCell

        cell.text = items[indexPath.item]

        return cell
    }
}

