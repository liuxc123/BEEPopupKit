//
//  EntryAppearanceDescriptor.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

/**
 An anti-pattern for SwiftEntryKit views to know more about their appearence,
 if necessary, since views don't have access to EKAttributes.
 This is a solution to bug #117 (round buttons in alert)
 */
protocol EntryAppearanceDescriptor: class {
    var bottomCornerRadius: CGFloat { get set }
}
