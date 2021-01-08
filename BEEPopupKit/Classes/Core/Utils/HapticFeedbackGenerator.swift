//
//  HapticFeedbackGenerator.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

struct HapticFeedbackGenerator {
    @available(iOS 10.0, *)
    static func notification(type: BEEAttributes.NotificationHapticFeedback) {
        guard let value = type.value else {
            return
        }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(value)
    }
}

