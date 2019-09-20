//
//  HeaderTableViewCell.swift
//  bankApp
//
//  Created by Raphael Oliveira Chagas on 13/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        self.contentView.isAccessibilityElement = true
        self.contentView.accessibilityLabel = "Recentes"
    }
}
