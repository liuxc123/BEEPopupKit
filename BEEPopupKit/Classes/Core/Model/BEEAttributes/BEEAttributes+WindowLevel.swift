//
//  BEEAttributes+WindowLevel.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

public extension BEEAttributes {

    /** Describes the window level in which the entry would be displayed */
    enum WindowLevel {

        /** Above the alerts */
        case alerts

        /** Above the status bar */
        case statusBar

        /** Above the application window */
        case normal

        /** Custom level */
        case custom(level: UIWindow.Level)

        /** Returns the raw value - the window level itself */
        public var value: UIWindow.Level {
            switch self {
            case .alerts:
                return .alert
            case .statusBar:
                return .statusBar
            case .normal:
                return .normal
            case .custom(level: let level):
                return level
            }
        }
    }
}

