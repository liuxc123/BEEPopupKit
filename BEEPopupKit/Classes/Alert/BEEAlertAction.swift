//
//  BEEAlertAction.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

public enum BEEActionStyle {
    case `default`
    case cancel
    case destructive
}

public class BEEAlertAction {
    public let title: String
    public var attributedTitle: NSAttributedString?
    public var style: BEEActionStyle
    public var completion: ((BEEAlertAction) -> Swift.Void)?

    public var backgroundColor: BEEColor?
    public var titleColor: BEEColor?
    public var titleFont: UIFont?
    public var disabled: Bool = false
    public var canAutoHide: Bool = true

    public init(title: String, style: BEEActionStyle, disabled: Bool = false, canAutoHide: Bool = true, handler: ((BEEAlertAction) -> Swift.Void)? = nil) {
        self.title = title
        self.style = style
        self.disabled = disabled
        self.canAutoHide = canAutoHide
        self.completion = handler
    }
}

