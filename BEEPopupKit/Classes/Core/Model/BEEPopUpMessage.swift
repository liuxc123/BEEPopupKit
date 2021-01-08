//
//  BEEPopUpMessage.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

public struct BEEPopUpMessage {

    /** Code block that is executed as the user taps the popup button */
    public typealias BEEPopUpMessageAction = () -> ()

    /** Popup theme image */
    public struct ThemeImage {

        /** Position of the theme image */
        public enum Position {
            case topToTop(offset: CGFloat)
            case centerToTop(offset: CGFloat)
        }

        /** The content of the image */
        public var image: BEEProperty.ImageContent

        /** The psotion of the image */
        public var position: Position

        /** Initializer */
        public init(image: BEEProperty.ImageContent,
                    position: Position = .topToTop(offset: 40)) {
            self.image = image
            self.position = position
        }
    }

    public var themeImage: ThemeImage?
    public var title: BEEProperty.LabelContent
    public var description: BEEProperty.LabelContent
    public var button: BEEProperty.ButtonContent
    public var action: BEEPopUpMessageAction

    var containsImage: Bool {
        return themeImage != nil
    }

    public init(themeImage: ThemeImage? = nil,
                title: BEEProperty.LabelContent,
                description: BEEProperty.LabelContent,
                button: BEEProperty.ButtonContent,
                action: @escaping BEEPopUpMessageAction) {
        self.themeImage = themeImage
        self.title = title
        self.description = description
        self.button = button
        self.action = action
    }
}

