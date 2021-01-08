//
//  BEEActionSheetView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

public struct BEEActionSheetViewConfig {

    static let globalConfig = BEEActionSheetViewConfig()

    var buttonHeight: CGFloat = 50
    var cornerRadius: CGFloat = 10

    var titleFont: UIFont = .systemFont(ofSize: 18)
    var messageFont: UIFont = .systemFont(ofSize: 14)
    var buttonFont: UIFont = .systemFont(ofSize: 17)

    var backgroundColor: UIColor = UIColor(hex6: 0xFFFFFF)
    var titleColor: UIColor = UIColor(hex6: 0x333333)
    var messageColor: UIColor = UIColor(hex6: 0x666666)
    var separatorColor: UIColor = UIColor(hex6: 0xCCCCCC)
    var spaceColor: UIColor = UIColor(hex6: 0xCCCCCC)

    var actionNormalColor: UIColor = UIColor(hex6: 0x333333)
    var actionHighlightColor: UIColor = UIColor(hex6: 0xE76153)
    var actionDisableColor: UIColor = UIColor(hex6: 0x999999)
    var actionCancelColor: UIColor = UIColor(hex6: 0x333333)
    var actionPressedColor: UIColor = UIColor(hex6: 0xEFEDE7)

    var titleTextAlignment: NSTextAlignment = .center
    var messageTextAlignment: NSTextAlignment = .center
    var buttonTextAlignment: NSTextAlignment = .center

    var spaceHeight: CGFloat = 10
    var imageSize: CGSize = CGSize(width: 50, height: 50)

    var displayMode: BEEAttributes.DisplayMode = .dark

    var defaultTextCancel: String = "取消"

    private init() {}
}

open class BEEActionSheetView {

    public var actions = [BEEAlertAction]()
    public var title: String!
    public var message: String!
    public var imageName: String!

    public var config: BEEActionSheetViewConfig = BEEActionSheetViewConfig.globalConfig

    public init(title: String, message: String, imageName: String? = nil) {
        self.title = title
        self.message = message
        self.imageName = imageName
    }

    public func addAction(action: BEEAlertAction) {
        self.actions.append(action)
    }

    private var actionSheetAttributes: BEEAttributes {
        var attributes: BEEAttributes = .bottomToast
        attributes.displayDuration = .infinity
        attributes.positionConstraints.size = .init(width: .fill, height: .intrinsic)
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        attributes.screenBackground = .color(color: BEEColor.black.with(alpha: 0.4))
        attributes.entryBackground = .color(color: BEEColor(config.backgroundColor))
        attributes.screenInteraction = .absorbTouches
        attributes.entryInteraction = .absorbTouches
        attributes.roundCorners = .top(radius: config.cornerRadius)
        attributes.border = .value(color: .black, width: 0.3)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 5))
        attributes.precedence = .enqueue(priority: .high)
        return attributes
    }

    public func show() {
        let titleContent = BEEProperty.LabelContent(
            text: title,
            style: .init(
                font: config.titleFont,
                color: BEEColor(config.titleColor),
                alignment: config.titleTextAlignment,
                displayMode: config.displayMode
            ),
            accessibilityIdentifier: title
        )

        let descriptionContent = BEEProperty.LabelContent(
            text: message,
            style: .init(
                font: config.messageFont,
                color: BEEColor(config.messageColor),
                alignment: config.messageTextAlignment,
                displayMode: config.displayMode
            )
        )

        var imageContent: BEEProperty.ImageContent?
        if let imageName = imageName, let _ = UIImage(named: imageName) {
            imageContent = BEEProperty.ImageContent(
                imageName: imageName,
                displayMode: config.displayMode,
                size: config.imageSize,
                contentMode: .scaleAspectFit,
                accessibilityIdentifier: "image"
            )
        }

        let simpleMessage = BEESimpleMessage(image: imageContent,
                                             title: titleContent,
                                             description: descriptionContent)

        var buttonContents = [BEEProperty.ButtonContent]()
        for action in actions
        {
            if action.style == .cancel {
                continue
            }

            var textColor: UIColor!
            switch action.style {
            case .normal:
                textColor = config.actionNormalColor
            case .highlight, .cancel:
                textColor = config.actionHighlightColor
            case .disabled:
                textColor = config.actionDisableColor
            }

            let buttonLabel = BEEProperty.LabelContent(
                text: action.title,
                style: BEEProperty.LabelStyle(
                    font: config.buttonFont,
                    color: BEEColor(textColor),
                    alignment: config.buttonTextAlignment,
                    displayMode: config.displayMode
                )
            )
            let buttonContent = BEEProperty.ButtonContent(
                label: buttonLabel,
                backgroundColor: BEEColor(action.backgroundColor ?? .clear),
                highlightedBackgroundColor: BEEColor(config.actionPressedColor),
                accessibilityIdentifier: action.title) {
                    BEEPopupKit.dismiss()
                    action.completion?(action)
            }
            buttonContents.append(buttonContent)
        }
        let buttonsBarContent = BEEProperty.ButtonBarContent(
            with: buttonContents,
            separatorColor: BEEColor(config.separatorColor),
            buttonHeight: config.buttonHeight,
            displayMode: config.displayMode
        )

        var cancelButtonContents = [BEEProperty.ButtonContent]()
        for action in actions
        {
            guard cancelButtonContents.isEmpty else {
                break
            }

            guard action.style == .cancel else {
                continue
            }

            let buttonLabel = BEEProperty.LabelContent(
                text: action.title.isEmpty ? config.defaultTextCancel : action.title,
                style: BEEProperty.LabelStyle(
                    font: config.buttonFont,
                    color: BEEColor(config.actionCancelColor),
                    alignment: config.buttonTextAlignment,
                    displayMode: config.displayMode
                )
            )
            let buttonContent = BEEProperty.ButtonContent(
                label: buttonLabel,
                backgroundColor: BEEColor(action.backgroundColor ?? .clear),
                highlightedBackgroundColor: BEEColor(config.actionPressedColor),
                accessibilityIdentifier: action.title) {
                    BEEPopupKit.dismiss()
                    action.completion?(action)
            }
            cancelButtonContents.append(buttonContent)
        }
        let cancelButtonsBarContent = BEEProperty.ButtonBarContent(
            with: cancelButtonContents,
            separatorColor: BEEColor(config.separatorColor),
            buttonHeight: config.buttonHeight,
            displayMode: config.displayMode
        )

        let cancelSpaceContent = BEEProperty.SpaceContent(
            backgroundColor: BEEColor(config.spaceColor),
            height: config.spaceHeight
        )

        let alertMessage = BEEAlertMessage(
            simpleMessage: simpleMessage,
            imagePosition: .top,
            buttonBarContent: buttonsBarContent,
            cancelSpaceContent: cancelSpaceContent,
            cancelButtonBarContent: cancelButtonsBarContent
        )
        let contentView = BEEAlertMessageView(with: alertMessage)

        BEEPopupKit.display(entry: contentView, using: actionSheetAttributes)
    }

}


