//
//  BEEProperty.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

public struct BEEProperty {

    /** Button content descriptor */
    public struct ButtonContent {

        public typealias Action = () -> ()

        /** Button title label content descriptor */
        public var label: LabelContent

        /** Button background color */
        public var backgroundColor: BEEColor
        public var highlightedBackgroundColor: BEEColor

        /** Content edge inset */
        public var contentEdgeInset: CGFloat

        /** The display mode of the button */
        public var displayMode: BEEAttributes.DisplayMode

        /** Accessibility identifier that identifies the button */
        public var accessibilityIdentifier: String?

        /** Action */
        public var action: Action?

        public init(label: LabelContent,
                    backgroundColor: BEEColor,
                    highlightedBackgroundColor: BEEColor,
                    contentEdgeInset: CGFloat = 5,
                    displayMode: BEEAttributes.DisplayMode = .inferred,
                    accessibilityIdentifier: String? = nil,
                    action: @escaping Action = {}) {
            self.label = label
            self.backgroundColor = backgroundColor
            self.highlightedBackgroundColor = highlightedBackgroundColor
            self.contentEdgeInset = contentEdgeInset
            self.displayMode = displayMode
            self.accessibilityIdentifier = accessibilityIdentifier
            self.action = action
        }

        public func backgroundColor(for traitCollection: UITraitCollection) -> UIColor {
            return backgroundColor.color(for: traitCollection, mode: displayMode)
        }

        public func highlightedBackgroundColor(for traitCollection: UITraitCollection) -> UIColor {
            return highlightedBackgroundColor.color(for: traitCollection, mode: displayMode)
        }

        public func highlighedLabelColor(for traitCollection: UITraitCollection) -> UIColor {
            return label.style.color.with(alpha: 0.8).color(
                for: traitCollection,
                mode: label.style.displayMode
            )
        }
    }

    /** Label content descriptor */
    public struct LabelContent {

        /** The text */
        public var text: String

        /** The attribute  text */
        public var attributedText: NSAttributedString?

        /** The label's style */
        public var style: LabelStyle

        /** The label's accessibility ideentifier */
        public var accessibilityIdentifier: String?

        public init(text: String,
                    attributedText: NSAttributedString? = nil,
                    style: LabelStyle,
                    accessibilityIdentifier: String? = nil) {
            self.text = text
            self.attributedText = attributedText
            self.style = style
            self.accessibilityIdentifier = accessibilityIdentifier
        }
    }

    /** Label style descriptor */
    public struct LabelStyle {

        /** Font of the text */
        public var font: UIFont

        /** Color of the text */
        public var color: BEEColor

        /** Text Alignment */
        public var alignment: NSTextAlignment

        /** Number of lines */
        public var numberOfLines: Int

        /** Display mode for the label */
        public var displayMode: BEEAttributes.DisplayMode

        public init(font: UIFont,
                    color: BEEColor,
                    alignment: NSTextAlignment = .left,
                    displayMode: BEEAttributes.DisplayMode = .inferred,
                    numberOfLines: Int = 0) {
            self.font = font
            self.color = color
            self.alignment = alignment
            self.displayMode = displayMode
            self.numberOfLines = numberOfLines
        }

        public func color(for traitCollection: UITraitCollection) -> UIColor {
            return color.color(for: traitCollection, mode: displayMode)
        }
    }

    /** Image View style descriptor */
    public struct ImageContent {

        /** Repeated-reversed animation throughout the presentation of an image */
        public enum TransformAnimation {
            case animate(duration: TimeInterval, options: UIView.AnimationOptions, transform: CGAffineTransform)
            case none
        }

        /** Tint color for the image/s */
        public var tint: BEEColor?

        /** The images */
        public var images: [UIImage]

        /** Image sequence duration, if any */
        public var imageSequenceAnimationDuration: TimeInterval

        /** Image View size - can be forced.
         If nil, then the image view hugs content and resists compression */
        public var size: CGSize?

        /** Content mode */
        public var contentMode: UIView.ContentMode

        /** Should the image be rounded */
        public var makesRound: Bool

        /** Repeated-Reversed animation */
        public var animation: TransformAnimation

        /** The display mode of the image */
        public var displayMode: BEEAttributes.DisplayMode

        /** Image accessibility identifier */
        public var accessibilityIdentifier: String?

        public init(imageName: String,
                    animation: TransformAnimation = .none,
                    displayMode: BEEAttributes.DisplayMode = .inferred,
                    size: CGSize? = nil,
                    contentMode: UIView.ContentMode = .scaleToFill,
                    tint: BEEColor? = nil,
                    makesRound: Bool = false,
                    accessibilityIdentifier: String? = nil) {
            let image = UIImage(named: imageName)!
            self.init(image: image,
                      displayMode: displayMode,
                      size: size,
                      tint: tint,
                      contentMode: contentMode,
                      makesRound: makesRound,
                      accessibilityIdentifier: accessibilityIdentifier)
        }

        public init(image: UIImage,
                    animation: TransformAnimation = .none,
                    displayMode: BEEAttributes.DisplayMode = .inferred,
                    size: CGSize? = nil,
                    tint: BEEColor? = nil,
                    contentMode: UIView.ContentMode = .scaleToFill,
                    makesRound: Bool = false,
                    accessibilityIdentifier: String? = nil) {
            self.images = [image]
            self.size = size
            self.tint = tint
            self.displayMode = displayMode
            self.contentMode = contentMode
            self.makesRound = makesRound
            self.animation = animation
            self.imageSequenceAnimationDuration = 0
            self.accessibilityIdentifier = accessibilityIdentifier
        }

        public init(images: [UIImage],
                    imageSequenceAnimationDuration: TimeInterval = 1,
                    displayMode: BEEAttributes.DisplayMode = .inferred,
                    animation: TransformAnimation = .none,
                    size: CGSize? = nil,
                    tint: BEEColor? = nil,
                    contentMode: UIView.ContentMode = .scaleToFill,
                    makesRound: Bool = false,
                    accessibilityIdentifier: String? = nil) {
            self.images = images
            self.size = size
            self.displayMode = displayMode
            self.tint = tint
            self.contentMode = contentMode
            self.makesRound = makesRound
            self.animation = animation
            self.imageSequenceAnimationDuration = imageSequenceAnimationDuration
            self.accessibilityIdentifier = accessibilityIdentifier
        }

        public init(imagesNames: [String],
                    imageSequenceAnimationDuration: TimeInterval = 1,
                    displayMode: BEEAttributes.DisplayMode = .inferred,
                    animation: TransformAnimation = .none,
                    size: CGSize? = nil,
                    tint: BEEColor? = nil,
                    contentMode: UIView.ContentMode = .scaleToFill,
                    makesRound: Bool = false,
                    accessibilityIdentifier: String? = nil) {
            let images = imagesNames.map { return UIImage(named: $0)! }
            self.init(images: images,
                      imageSequenceAnimationDuration: imageSequenceAnimationDuration,
                      displayMode: displayMode,
                      animation: animation,
                      size: size,
                      tint: tint,
                      contentMode: contentMode,
                      makesRound: makesRound,
                      accessibilityIdentifier: accessibilityIdentifier)
        }

        /** Quick thumbail property generator */
        public static func thumb(with image: UIImage,
                                 edgeSize: CGFloat) -> ImageContent {
            return ImageContent(images: [image],
                                size: CGSize(width: edgeSize, height: edgeSize),
                                contentMode: .scaleAspectFill,
                                makesRound: true)
        }

        /** Quick thumbail property generator */
        public static func thumb(with imageName: String,
                                 edgeSize: CGFloat) -> ImageContent {
            return ImageContent(imagesNames: [imageName],
                                size: CGSize(width: edgeSize, height: edgeSize),
                                contentMode: .scaleAspectFill,
                                makesRound: true)
        }

        public func tintColor(for traitCollection: UITraitCollection) -> UIColor? {
            return tint?.color(for: traitCollection, mode: displayMode)
        }
    }

    /** Text field content **/
    public struct TextFieldContent {

        // NOTE: Intentionally a reference type
        class ContentWrapper {
            var text = ""
        }

        public weak var delegate: UITextFieldDelegate?
        public var keyboardType: UIKeyboardType
        public var isSecure: Bool
        public var leadingImage: UIImage!
        public var placeholder: LabelContent
        public var textStyle: LabelStyle
        public var tintColor: BEEColor!
        public var displayMode: BEEAttributes.DisplayMode
        public var bottomBorderColor: BEEColor
        public var accessibilityIdentifier: String?
        let contentWrapper = ContentWrapper()
        public var textContent: String {
            set {
                contentWrapper.text = newValue
            }
            get {
                return contentWrapper.text
            }
        }

        public init(delegate: UITextFieldDelegate? = nil,
                    keyboardType: UIKeyboardType = .default,
                    placeholder: LabelContent,
                    tintColor: BEEColor? = nil,
                    displayMode: BEEAttributes.DisplayMode = .inferred,
                    textStyle: LabelStyle,
                    isSecure: Bool = false,
                    leadingImage: UIImage? = nil,
                    bottomBorderColor: BEEColor = .clear,
                    accessibilityIdentifier: String? = nil) {
            self.delegate = delegate
            self.keyboardType = keyboardType
            self.placeholder = placeholder
            self.textStyle = textStyle
            self.tintColor = tintColor
            self.displayMode = displayMode
            self.isSecure = isSecure
            self.leadingImage = leadingImage
            self.bottomBorderColor = bottomBorderColor
            self.accessibilityIdentifier = accessibilityIdentifier
        }

        public func tintColor(for traitCollection: UITraitCollection) -> UIColor? {
            return tintColor?.color(for: traitCollection, mode: displayMode)
        }

        public func bottomBorderColor(for traitCollection: UITraitCollection) -> UIColor? {
            return bottomBorderColor.color(for: traitCollection, mode: displayMode)
        }
    }

    /** Button bar content */
    public struct ButtonBarContent {

        /** Button content array */
        public var content: [ButtonContent] = []

        /** The color of the separator */
        public var separatorColor: BEEColor

        /** Upper threshold for the number of buttons (*ButtonContent*) for horizontal distribution. Must be a positive value */
        public var horizontalDistributionThreshold: Int

        /** The height of each button. All are equally distributed in their axis */
        public var buttonHeight: CGFloat

        /** The display mode of the button bar */
        public var displayMode: BEEAttributes.DisplayMode

        public init(with buttonContents: ButtonContent...,
                    separatorColor: BEEColor,
                    horizontalDistributionThreshold: Int = 2,
                    buttonHeight: CGFloat = 50,
                    displayMode: BEEAttributes.DisplayMode = .inferred) {
            self.init(with: buttonContents,
                      separatorColor: separatorColor,
                      horizontalDistributionThreshold: horizontalDistributionThreshold,
                      buttonHeight: buttonHeight,
                      displayMode: displayMode)
        }

        public init(with buttonContents: [ButtonContent],
                    separatorColor: BEEColor,
                    horizontalDistributionThreshold: Int = 2,
                    buttonHeight: CGFloat = 50,
                    displayMode: BEEAttributes.DisplayMode = .inferred) {
            guard horizontalDistributionThreshold > 0 else {
                fatalError("horizontalDistributionThreshold Must have a positive value!")
            }
            self.separatorColor = separatorColor
            self.horizontalDistributionThreshold = horizontalDistributionThreshold
            self.buttonHeight = buttonHeight
            self.displayMode = displayMode
            content.append(contentsOf: buttonContents)
        }

        public func separatorColor(for traitCollection: UITraitCollection) -> UIColor {
            return separatorColor.color(for: traitCollection, mode: displayMode)
        }
    }

    /** Rating item content */
    public struct BEERatingItemContent {
        public var title: BEEProperty.LabelContent
        public var description: BEEProperty.LabelContent
        public var unselectedImage: BEEProperty.ImageContent
        public var selectedImage: BEEProperty.ImageContent
        public var size: CGSize

        public init(title: BEEProperty.LabelContent,
                    description: BEEProperty.LabelContent,
                    unselectedImage: BEEProperty.ImageContent,
                    selectedImage: BEEProperty.ImageContent,
                    size: CGSize = CGSize(width: 50, height: 50)) {
            self.title = title
            self.description = description
            self.unselectedImage = unselectedImage
            self.selectedImage = selectedImage
            self.size = size
        }
    }

    /** Space content descriptor */
    public struct SpaceContent {

        public let height: CGFloat
        public let backgroundColor: BEEColor
        public var displayMode: BEEAttributes.DisplayMode

        public init(backgroundColor: BEEColor,
                    height: CGFloat = 10,
                    displayMode: BEEAttributes.DisplayMode = .inferred) {
            self.backgroundColor = backgroundColor
            self.height = height
            self.displayMode = displayMode
        }

        public func backgroundColor(for traitCollection: UITraitCollection) -> UIColor {
            return backgroundColor.color(for: traitCollection, mode: displayMode)
        }

    }

    /** Custom view descriptor */
    public class CustomContent {

        /** The view */
        public var view: UIView

        public init(view: UIView) {
            self.view = view
        }
    }
}

