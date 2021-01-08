//
//  BEEAttributes+Position.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import Foundation

public extension BEEAttributes {

    /** The position of the entry. */
    enum Position {

        /** The entry appears at the top of the screen. */
        case top

        /** The entry appears at the top left of the screen. */
        case topLeft

        /** The entry appears at the top right of the screen. */
        case topRight

        /** The entry appears at the bottom of the screen. */
        case bottom

        /** The entry appears at the bottom left of the screen. */
        case bottomLeft

        /** The entry appears at the bottom right of the screen. */
        case bottomRight

        /** The entry appears at the center of the screen. */
        case center

        /** The entry appears at the center left of the screen. */
        case centerLeft

        /** The entry appears at the center right of the screen. */
        case centerRight

        public var isTop: Bool {
            return self == .top
        }

        public var isTopLeft: Bool {
            return self == .topLeft
        }

        public var isTopRight: Bool {
            return self == .topRight
        }

        public var isCenter: Bool {
            return self == .center
        }

        public var isCenterLeft: Bool {
            return self == .centerLeft
        }

        public var isCenterRight: Bool {
            return self == .centerRight
        }

        public var isBottom: Bool {
            return self == .bottom
        }

        public var isBottomLeft: Bool {
            return self == .bottomLeft
        }
        public var isBottomRight: Bool {
            return self == .bottomRight
        }
    }
}
