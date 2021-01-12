//
//  BEEHUDAttributes.swift
//  HHProgressHUD
//
//  Created by ios on 2019/11/30.
//

import UIKit

public struct BEEHUDConfig {
    
    public static var shared = BEEHUDConfig()
    
    public var textColor: UIColor = .white
    public var textFont: UIFont = .systemFont(ofSize: 16)
    public var textAlightment: NSTextAlignment = .center
    public var textNumberOfLines: Int = 0

    
    public var defaultDuration: TimeInterval = 2.0
    public var verticalOffset: CGFloat = 80

    public var displayMode: BEEAttributes.DisplayMode = .inferred
}

// MARK: - Hud BEEAttributes Extension

extension BEEAttributes {
    static var bee_hud: BEEAttributes {
        var attributes = BEEAttributes.centerFloat
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: false)
        attributes.windowLevel = .statusBar
        attributes.screenInteraction = .absorbTouches
        attributes.entryInteraction = .absorbTouches
        attributes.displayDuration = 3
        attributes.hapticFeedbackType = .none
        attributes.popBehavior = .overridden
        attributes.precedence = .override(priority: .high, dropEnqueuedEntries: false)
        attributes.entryBackground = .color(color: BEEColor(red: 50, green: 50, blue: 50))
        attributes.positionConstraints.size = .intrinsic
        attributes.positionConstraints.maxSize = .init(width: .constant(value: min(UIScreen.main.bounds.size.width - 20, UIScreen.main.bounds.size.height - 20)), height: .intrinsic)
        attributes.entranceAnimation = .init(
            scale: .init(
                from: 0.9,
                to: 1,
                duration: 0.4,
                spring: .init(damping: 1, initialVelocity: 0)
            ),
            fade: .init(
                from: 0,
                to: 1,
                duration: 0.3
            )
        )
        attributes.exitAnimation = .init(
            fade: .init(
                from: 1,
                to: 0,
                duration: 0.2
            )
        )
        attributes.shadow = .active(with: .init(color: BEEColor(red: 50, green: 50, blue: 50), opacity: 0.5, radius: 5))
        attributes.statusBar = .dark
        attributes.roundCorners = .all(radius: 15)
        attributes.scroll = .disabled
        attributes.positionConstraints.maxSize = .init(width: .constant(value: min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)), height: .intrinsic)
        return attributes
    }
}

// MARK: - Hud LabelStyle Extension

extension BEEProperty.LabelStyle {
    static var bee_hud: BEEProperty.LabelStyle {
        let style = BEEProperty.LabelStyle(
            font: UIFont.boldSystemFont(ofSize: 18),
            color: .white,
            alignment: .center,
            displayMode: .inferred,
            numberOfLines: 0
        )
        return style
    }
}
