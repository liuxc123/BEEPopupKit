//
//  BEEToastAttributes.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/12.
//

import UIKit

public struct BEEToastConfig {
    
    public static var shared = BEEToastConfig()
    
    public var textColor: UIColor = .white
    public var textFont: UIFont = .systemFont(ofSize: 16)
    public var textAlightment: NSTextAlignment = .left
    public var numberOfLines: Int = 0
    
    public var defaultDuration: TimeInterval = 2.0
    public var verticalOffset: CGFloat = 80

    public var displayMode: BEEAttributes.DisplayMode = .inferred
}


extension BEEAttributes {
    
    static var bee_toast: BEEAttributes {
        var attributes = BEEAttributes.bottomFloat
        attributes.positionConstraints = .float
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: false)
        attributes.windowLevel = .statusBar
        attributes.hapticFeedbackType = .none
        attributes.entryInteraction = .absorbTouches
        attributes.entryBackground = .color(color: BEEColor(red: 50, green: 50, blue: 50))
        attributes.popBehavior = .overridden
        attributes.shadow = .active(with: .init(color: BEEColor(red: 50, green: 50, blue: 50), opacity: 0.5, radius: 5))
        attributes.statusBar = .dark
        attributes.roundCorners = .all(radius: 3)
        attributes.scroll = .disabled
        attributes.precedence = .override(priority: .normal, dropEnqueuedEntries: true)
        attributes.positionConstraints.size = .intrinsic
        attributes.positionConstraints.maxSize = .init(width: .constant(value: min(UIScreen.main.bounds.size.width - 20, UIScreen.main.bounds.size.height - 20)), height: .intrinsic)
        attributes.entranceAnimation = .init(
            scale: .init(from: 0.9, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)),
            fade: .init(from: 0, to: 1, duration: 0.3)
        )
        attributes.exitAnimation = .init(
            fade: .init(from: 1, to: 0, duration: 0.2)
        )
        return attributes
    }
    
}
