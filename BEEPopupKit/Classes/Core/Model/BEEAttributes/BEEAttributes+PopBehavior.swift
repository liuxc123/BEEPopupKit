//
//  BEEAttributes+PopBehavior.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import Foundation

public extension BEEAttributes {

    /** Describes the entry behavior when a new entry shows (with equal or higher display-priority) */
    enum PopBehavior {

        /** The entry disappears promptly (Does not animates out) when a new one shows */
        case overridden

        /** Animate the entry out - The entry rolls out when a new one shows */
        case animated(animation: Animation)

        public var isOverriden: Bool {
            switch self {
            case .overridden:
                return true
            case .animated:
                return false
            }
        }

        var animation: Animation? {
            switch self {
            case .animated(animation: let animation):
                return animation
            case .overridden:
                return nil
            }
        }

        func validate() {
            #if DEBUG
            guard let animation = animation else { return }
            guard animation == .none else { return }
            print("""
            BEEPopupView warning: cannot associate value `BEEAttributes.Animation()`
            with `BEEAttributes.PopBehavior.animated`. This may result in undefined behavior.
            Please use `PopBehavior.overridden` instead.
            """)
            #endif
        }
    }
}

