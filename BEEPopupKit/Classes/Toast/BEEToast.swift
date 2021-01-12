//
//  BEEToast.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

public class BEEToast {
    
    private init() {}
    
    public static func show(_ text: String, view: UIView? = nil, duration: TimeInterval? = nil, verticalOffset: CGFloat? = nil) {

        let config = BEEToastConfig.shared
        var attributes = BEEAttributes.bee_toast
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
        if let view = view {
            BEEPopupKit.display(entry: contentView, using: attributes, presentView: view)
        } else {
            BEEPopupKit.display(entry: contentView, using: attributes)
        }
    }
    
}

