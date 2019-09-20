//
//  StatementsTableViewCell.swift
//  bankApp
//
//  Created by Raphael Oliveira Chagas on 13/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import UIKit

class StatementsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var holderView: UIView!
    
    func setRounded() {
        self.setCornerAndShadow(self.holderView)
        self.setCornerAndShadow(self.shadowView)
    }
    
    func setAccessibility() {
        self.contentView.isAccessibilityElement = true
        let title = titleLabel.text ?? ""
        let date = dateLabel.text ?? ""
        let description = descriptionLabel.text ?? ""
        let value = valueLabel.text ?? ""
        let label = "\(title), \(date), \(description), \(value)"
        self.contentView.accessibilityLabel = label
    }
    
    func setCornerAndShadow(_ view: UIView) {
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor(red: 91 / 255.0, green: 81 / 255.0, blue: 73 / 255.0, alpha: 0.20).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 2
    }
}
