//
//  BEEAlertView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

public struct BEEAlertViewConfig {

    public static var shared = BEEAlertViewConfig()

    public var width: CGFloat = 275
    public var buttonHeight: CGFloat = 50
    public var cornerRadius: CGFloat = 5

    public var titleFont: UIFont = .systemFont(ofSize: 18)
    public var messageFont: UIFont = .systemFont(ofSize: 14)
    public var buttonFont: UIFont = .systemFont(ofSize: 17)

    public var backgroundColor: BEEColor = BEEColor(light: UIColor(hex6: 0xFFFFFF), dark: UIColor(hex6: 0xFFFFFF).darken(by: 0.8))
    public var titleColor: BEEColor = BEEColor(light: UIColor(hex6: 0x333333), dark: UIColor(hex6: 0x333333).lighten(by: 0.8))
    public var messageColor: BEEColor = BEEColor(light: UIColor(hex6: 0x666666), dark: UIColor(hex6: 0x666666).lighten(by: 0.8))
    public var separatorColor: BEEColor = BEEColor(light: UIColor(hex6: 0xF1F2F4), dark: UIColor(hex6: 0xF1F2F4).darken(by: 0.8))

    public var actionNormalColor: BEEColor = BEEColor(light: UIColor(hex6: 0x333333), dark: UIColor(hex6: 0x333333).lighten(by: 0.8))
    public var actionCancelColor: BEEColor = BEEColor(light: UIColor(hex6: 0x333333), dark: UIColor(hex6: 0x333333).lighten(by: 0.8))
    public var actionDestructiveColor: BEEColor = BEEColor(light: UIColor(hex6: 0xE76153), dark: UIColor(hex6: 0xE76153).lighten(by: 0.8))
    public var actionDisableColor: BEEColor = BEEColor(light: UIColor(hex6: 0x999999), dark: UIColor(hex6: 0x999999).lighten(by: 0.8))
    public var actionPressedColor: BEEColor = BEEColor(light: UIColor(hex6: 0xEFEDE7), dark: UIColor(hex6: 0xEFEDE7).darken(by: 0.8))

    public var titleTextAlignment: NSTextAlignment = .center
    public var messageTextAlignment: NSTextAlignment = .center
    public var buttonTextAlignment: NSTextAlignment = .center

    public var imageSize: CGSize = CGSize(width: 50, height: 50)
    public var horizontalButtonCount = 2

    public var name: String? = "ActionSheet"
    public var precedence: BEEAttributes.Precedence = .override(priority: .normal, dropEnqueuedEntries: false)
    public var displayMode: BEEAttributes.DisplayMode = .inferred

    private init() {}
}


open class BEEAlertView {

    public var actions = [BEEAlertAction]()
    public var title: String!
    public var attributedTitle: NSAttributedString?
    public var message: String!
    public var attributedMessage: NSAttributedString?
    public var imageName: String!
    public var imageSize: CGSize?
    public var customHeaderView: UIView?
    public var customActionSequenceView: UIView?

    public var config: BEEAlertViewConfig = BEEAlertViewConfig.shared

    public init(title: String, message: String, imageName: String = "") {
        self.title = title
        self.message = message
        self.imageName = imageName
    }

    public func addAction(_ action: BEEAlertAction) {
        self.actions.append(action)
    }

    public lazy var attributes: BEEAttributes = {
        var attributes: BEEAttributes

        attributes = .centerFloat
        attributes.name = config.name
        attributes.windowLevel = .alerts
        attributes.displayDuration = .infinity
        attributes.precedence = config.precedence
        attributes.displayMode = config.displayMode
        attributes.hapticFeedbackType = .success
        attributes.screenInteraction = .absorbTouches
        attributes.entryInteraction = .absorbTouches
        attributes.screenBackground = .color(color: BEEColor.black.with(alpha: 0.4))
        attributes.entryBackground = .color(color: config.backgroundColor)
        attributes.scroll = .disabled
        attributes.roundCorners = .all(radius: config.cornerRadius)
        attributes.border = .value(color: .black, width: 0.3)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 5))
        attributes.positionConstraints.size = .init(width: .constant(value: config.width), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(
            width: .constant(value: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) ),
            height: .ratio(value: 0.9)
        )
        attributes.entranceAnimation = .init(
            scale: .init(from: 0.9, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)),
            fade: .init(from: 0, to: 1, duration: 0.3)
        )
        attributes.exitAnimation = .init(
            fade: .init(from: 1, to: 0, duration: 0.2)
        )
        attributes.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 10, screenEdgeResistance: .none))
        return attributes
    }()

    public func show(view: UIView? = nil) {
        let titleContent = BEEProperty.LabelContent(
            text: title,
            attributedText: attributedTitle,
            style: .init(
                font: config.titleFont,
                color: config.titleColor,
                alignment: config.titleTextAlignment,
                displayMode: config.displayMode
            ),
            accessibilityIdentifier: title
        )

        let descriptionContent = BEEProperty.LabelContent(
            text: message,
            attributedText: attributedMessage,
            style: .init(
                font: config.messageFont,
                color: config.messageColor,
                alignment: config.messageTextAlignment,
                displayMode: config.displayMode
            )
        )

        var imageContent: BEEProperty.ImageContent?
        if let _ = UIImage(named: imageName) {
            imageContent = BEEProperty.ImageContent(
                imageName: imageName,
                displayMode: config.displayMode,
                size: imageSize ?? config.imageSize,
                contentMode: .scaleAspectFit,
                accessibilityIdentifier: "image"
            )
        }

        var customHeaderContent: BEEProperty.CustomContent?
        if let customHeaderView = self.customHeaderView {
            customHeaderContent = BEEProperty.CustomContent(view: customHeaderView)
        }

        var customActionContent: BEEProperty.CustomContent?
        if let customActionView = self.customActionSequenceView {
            customActionContent = BEEProperty.CustomContent(view: customActionView)
        }

        var buttonContents = [BEEProperty.ButtonContent]()
        for action in actions
        {
            var textColor: BEEColor!
            switch action.style {
            case .default:
                textColor = config.actionNormalColor
            case .cancel:
                textColor = config.actionCancelColor
            case .destructive:
                textColor = config.actionDestructiveColor
            }
            if action.disabled {
                textColor = config.actionDisableColor
            }

            let buttonLabel = BEEProperty.LabelContent(
                text: action.title,
                attributedText: action.attributedTitle,
                style: BEEProperty.LabelStyle(
                    font: config.buttonFont,
                    color: textColor,
                    alignment: config.buttonTextAlignment,
                    displayMode: config.displayMode
                )
            )
            let buttonContent = BEEProperty.ButtonContent(
                label: buttonLabel,
                backgroundColor: action.backgroundColor ?? .clear,
                highlightedBackgroundColor: config.actionPressedColor,
                
                accessibilityIdentifier: action.title) {
                    if action.disabled { return }
                    if action.canAutoHide {
                        if let presentView = view {
                            BEEPopupKit.dismiss(form: presentView, descriptor: .displayed) {
                                action.handler?(action)
                            }
                        } else {
                            BEEPopupKit.dismiss(.displayed) {
                                action.handler?(action)
                            }
                        }
                    } else {
                        action.handler?(action)
                    }
            }
            buttonContents.append(buttonContent)
        }
        let buttonsBarContent = BEEProperty.ButtonBarContent(
            with: buttonContents,
            separatorColor: config.separatorColor,
            horizontalDistributionThreshold: config.horizontalButtonCount,
            buttonHeight: config.buttonHeight,
            displayMode: config.displayMode
        )

        let alertMessage = BEEAlertMessage(
            image: imageContent,
            title: titleContent,
            description: descriptionContent,
            custom: customHeaderContent,
            buttonBarContent: buttonsBarContent,
            customAction: customActionContent,
            backgroundColor: config.backgroundColor,
            displayMode: config.displayMode
        )
        let contentView = BEEAlertMessageView(with: alertMessage)

        if let presentView = view {
            BEEPopupKit.display(entry: contentView, using: attributes, presentView: presentView)
        } else {
            BEEPopupKit.display(entry: contentView, using: attributes)
        }
    }

}
