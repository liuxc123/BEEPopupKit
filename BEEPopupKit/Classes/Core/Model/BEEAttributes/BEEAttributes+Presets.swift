//
//  BEEAttributes+Presets.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import Foundation

public extension BEEAttributes {

    /** Default attributes - Can be mutated according to the hosting application theme */
    static var `default` = BEEAttributes()

    /** Toast preset - The frame fills margins and safe area is filled with background view */
    static var toast: BEEAttributes {
        var attributes = BEEAttributes()
        attributes.positionConstraints = .fullWidth
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        attributes.windowLevel = .statusBar
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.popBehavior = .animated(animation: .translation)
        return attributes
    }

    /** Float preset - The frame is margined and the safe area is left cleared */
    static var float: BEEAttributes {
        var attributes = BEEAttributes()
        attributes.positionConstraints = .float
        attributes.roundCorners = .all(radius: 10)
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: false)
        attributes.windowLevel = .statusBar
        return attributes
    }

    /** Preset for top float entry */
    static var topFloat: BEEAttributes {
        var attributes = float
        attributes.position = .top
        return attributes
    }

    /** Preset for a bottom float entry */
    static var bottomFloat: BEEAttributes {
        var attributes = float
        attributes.position = .bottom
        return attributes
    }

    /** Preset for a center float entry */
    static var centerFloat: BEEAttributes {
        var attributes = float
        attributes.position = .center
        return attributes
    }

    /** Preset for a bottom toast entry */
    static var bottomToast: BEEAttributes {
        var attributes = toast
        attributes.position = .bottom
        return attributes
    }

    /** Preset for a top toast entry */
    static var topToast: BEEAttributes {
        var attributes = toast
        attributes.position = .top
        return attributes
    }

    /** Preset for a top note entry */
    static var topNote: BEEAttributes {
        var attributes = topToast
        attributes.scroll = .disabled
        attributes.windowLevel = .normal
        attributes.entryInteraction = .absorbTouches
        return attributes
    }

    /** Preset for a bottom note entry */
    static var bottomNote: BEEAttributes {
        var attributes = bottomToast
        attributes.scroll = .disabled
        attributes.windowLevel = .normal
        attributes.entryInteraction = .absorbTouches
        return attributes
    }

    /** Preset for a status bar entry - appears on top of the status bar */
    static var statusBar: BEEAttributes {
        var attributes = topToast
        attributes.windowLevel = .statusBar
        attributes.entryInteraction = .absorbTouches
        attributes.positionConstraints.safeArea = .overridden
        return attributes
    }
}

