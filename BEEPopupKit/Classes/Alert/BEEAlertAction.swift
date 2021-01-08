//
//  BEEAlertAction.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

public enum BEEActionStyle {
    case normal
    case highlight
    case disabled
    case cancel
}

public struct BEEAlertAction {
    public let title: String
    public var style: BEEActionStyle
    public var completion: ((BEEAlertAction) -> Swift.Void)?

    public var backgroundColor: UIColor?
    public var textColor: UIColor?
    public var textFont: UIFont?
    public var highlight: Bool = false
    public var disabled: Bool = false

    public init(title: String, style: BEEActionStyle, handler: ((BEEAlertAction) -> Swift.Void)? = nil) {
        self.title = title
        self.style = style
        self.completion = handler

        switch style {
        case .normal, .cancel: break
        case .highlight: highlight = true
        case .disabled: disabled = true
        }
    }
}
