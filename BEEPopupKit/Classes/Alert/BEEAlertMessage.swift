//
//  BEEAlertMessage.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import Foundation
import UIKit

public struct BEEAlertMessage {

    /** The image view descriptor */
    public var image: BEEProperty.ImageContent?

    /** The title label descriptor */
    public let title: BEEProperty.LabelContent

    /** The description label descriptor */
    public let description: BEEProperty.LabelContent

    /** Custom View */
    public var custom: BEEProperty.CustomContent?

    /** Contents of button bar */
    public let buttonBarContent: BEEProperty.ButtonBarContent

    /** Custom Action View */
    public var customAction: BEEProperty.CustomContent?

    /** Contents of cancel space view */
    public var cancelSpaceContent: BEEProperty.SpaceContent?

    /** Contents of cancel button bar */
    public var cancelButtonBarContent: BEEProperty.ButtonBarContent?

    public var backgroundColor: BEEColor?

    /** Display mode for the label */
    public var displayMode: BEEAttributes.DisplayMode

    public init(image: BEEProperty.ImageContent? = nil,
                title: BEEProperty.LabelContent,
                description: BEEProperty.LabelContent,
                custom: BEEProperty.CustomContent? = nil,
                buttonBarContent: BEEProperty.ButtonBarContent,
                customAction: BEEProperty.CustomContent? = nil,
                cancelSpaceContent: BEEProperty.SpaceContent? = nil,
                cancelButtonBarContent: BEEProperty.ButtonBarContent? = nil,
                backgroundColor: BEEColor? = nil,
                displayMode: BEEAttributes.DisplayMode = .inferred) {
        self.image = image
        self.title = title
        self.description = description
        self.custom = custom
        self.buttonBarContent = buttonBarContent
        self.customAction = customAction
        self.cancelButtonBarContent = cancelButtonBarContent
        self.backgroundColor = backgroundColor
        self.displayMode = displayMode
    }
}



