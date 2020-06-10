//
//  TestCell.swift
//  RowHeightTest
//
//  Created by Gereon Steffens on 10.06.20.
//  Copyright © 2020 snabble. All rights reserved.
//

import UIKit

class TestCell: UICollectionViewCell {

    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!

    var text: String = "" {
        didSet {
            let len = text.count
            self.label1.text = "\(len) \(text)"
            self.label2.text = "\(len*2+1) \(text) \(text)"

            self.label1.sizeToFit()
            self.label2.sizeToFit()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }


}
