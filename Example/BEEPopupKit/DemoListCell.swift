//
//  DemoListCell.swift
//  BEEPopupKit_Example
//
//  Created by liuxc on 2021/1/12.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BEETableKit

class DemoListCell: UITableViewCell, ConfigurableCell {
    
    static var defaultHeight: CGFloat? {
        return 50
    }
    
    func configure(with text: String) {
        accessoryType = .disclosureIndicator
        textLabel?.text = text
        textLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
}
