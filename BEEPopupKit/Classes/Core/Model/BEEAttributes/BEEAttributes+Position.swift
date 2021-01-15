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

        /** The entry appears at the bottom of the screen. */
        case bottom

        /** The entry appears at the center of the screen. */
        case center

        public var isTop: Bool {
            return self == .top
        }

        public var isCenter: Bool {
            return self == .center
        }

        public var isBottom: Bool {
            return self == .bottom
        }
    }
}
