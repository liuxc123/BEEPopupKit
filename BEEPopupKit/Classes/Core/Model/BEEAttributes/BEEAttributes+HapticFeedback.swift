//
//  BEEAttributes+HapticFeedback.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

public extension BEEAttributes {

    /** Notification haptic feedback type. Adds an additional sensuous layer. Read more at UINotificationFeedbackType. Available from iOS 10, but you are not required to check the iOS version before using it. It's automatically handled by the kit.
     */
    enum NotificationHapticFeedback {
        case success
        case warning
        case error
        case none

        @available(iOS 10.0, *)
        var value: UINotificationFeedbackGenerator.FeedbackType? {
            switch self {
            case .success:
                return .success
            case .warning:
                return .warning
            case .error:
                return .error
            case .none:
                return nil
            }
        }

        var isValid: Bool {
            return self != .none
        }
    }
}

