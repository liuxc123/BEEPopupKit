//
//  BEEAttributes+DisplayMode.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import Foundation

public extension BEEAttributes {

    /** Display mode for the entry */
    enum DisplayMode {

        /** The display mode is inferred from the current user interface style */
        case inferred

        /** The display mode is light */
        case light

        /** The display mode is dark */
        case dark
    }
}

