//
//  BEEAlertMessage.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import Foundation
import UIKit

public struct BEEAlertMessage {

    public enum ImagePosition {
        case top
        case left
    }

    /** The position of the image inside the alert */
    public let imagePosition: ImagePosition

    /** Image, Title, Description */
    public let simpleMessage: BEESimpleMessage

    /** Contents of button bar */
    public let buttonBarContent: BEEProperty.ButtonBarContent

    /** Contents of cancel space view */
    public var cancelSpaceContent: BEEProperty.SpaceContent?

    /** Contents of cancel button bar */
    public var cancelButtonBarContent: BEEProperty.ButtonBarContent?

    public init(simpleMessage: BEESimpleMessage,
                imagePosition: ImagePosition = .top,
                buttonBarContent: BEEProperty.ButtonBarContent,
                cancelSpaceContent: BEEProperty.SpaceContent? = nil,
                cancelButtonBarContent: BEEProperty.ButtonBarContent? = nil) {
        self.simpleMessage = simpleMessage
        self.imagePosition = imagePosition
        self.buttonBarContent = buttonBarContent
        self.cancelButtonBarContent = cancelButtonBarContent
    }
}



