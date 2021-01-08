//
//  BEESimpleMessage.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import Foundation

public struct BEESimpleMessage {

    /** The image view descriptor */
    public let image: BEEProperty.ImageContent?

    /** The title label descriptor */
    public let title: BEEProperty.LabelContent

    /** The description label descriptor */
    public let description: BEEProperty.LabelContent

    public init(image: BEEProperty.ImageContent? = nil,
                title: BEEProperty.LabelContent,
                description: BEEProperty.LabelContent) {
        self.image = image
        self.title = title
        self.description = description
    }
}

