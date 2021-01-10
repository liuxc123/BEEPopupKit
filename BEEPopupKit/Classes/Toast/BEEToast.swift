//
//  BEEToast.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

public struct BEEToastConfig {
    
    static let globalConfig = BEEToastConfig()
    
    var textColor: UIColor = .white
    var textFont: UIFont = .systemFont(ofSize: 16)
    var textAlightment: NSTextAlignment = .left
    var numberOfLines: Int = 0
    
    var defaultDuration: TimeInterval = 2.0
    var verticalOffset: CGFloat = 80

    var displayMode: BEEAttributes.DisplayMode = .inferred
}

public class BEEToast {
    
    private init() {}
    
    private static var toastAttribute: BEEAttributes {
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
    
    public static func show(_ text: String, view: UIView? = nil, duration: TimeInterval? = nil, verticalOffset: CGFloat? = nil) {

        let config = BEEToastConfig.globalConfig
        var attributes = BEEToast.toastAttribute
        attributes.displayMode = config.displayMode
        attributes.displayDuration = duration ?? config.defaultDuration
        attributes.positionConstraints.verticalOffset = verticalOffset ?? config.verticalOffset

        let contentView = BEEToastMessageView(
            with: .init(text: text,
                        style: .init(font: config.textFont,
                                     color: BEEColor(config.textColor),
                                     alignment: config.textAlightment,
                                     displayMode: config.displayMode,
                                     numberOfLines: config.numberOfLines)))
        if let presentView = view {
            BEEPopupKit.display(entry: contentView, using: attributes, presentView: presentView)
        } else {
            BEEPopupKit.display(entry: contentView, using: attributes)
        }
    }
    
}

