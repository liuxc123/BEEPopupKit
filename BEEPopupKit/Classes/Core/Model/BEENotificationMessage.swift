//
//  BEENotificationMessage.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

public struct BEENotificationMessage {

    /** Insets of the content of the message */
    public struct Insets {

        /** The insets of the content of the message, from the top, bottom, left, right */
        public var contentInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        /** The distance between the title and the description */
        public var titleToDescription: CGFloat = 5

        public static var `default` = Insets()
    }

    /** Image, Title, Description */
    public let simpleMessage: BEESimpleMessage

    /** Optional auxiliary label descriptor (For instance, it be used to display time of message) */
    public let auxiliary: BEEProperty.LabelContent?

    /** Defines the vertical and horizontal margins */
    public let insets: Insets

    public init(simpleMessage: BEESimpleMessage,
                auxiliary: BEEProperty.LabelContent? = nil,
                insets: Insets = .default) {
        self.simpleMessage = simpleMessage
        self.auxiliary = auxiliary
        self.insets = insets
    }
}

