//
//  UIApplication+BEEAppearance.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

extension UIApplication {

    func set(statusBarStyle: BEEAttributes.StatusBar) {
        let appearance = statusBarStyle.appearance
        UIApplication.shared.isStatusBarHidden = !appearance.visible
        UIApplication.shared.statusBarStyle = appearance.style
    }
}

