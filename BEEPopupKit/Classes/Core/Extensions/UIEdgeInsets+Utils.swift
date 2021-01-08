//
//  UIEdgeInsets+Utils.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

extension UIEdgeInsets {
    var hasVerticalInsets: Bool {
        return top > 0 || bottom > 0
    }
}
