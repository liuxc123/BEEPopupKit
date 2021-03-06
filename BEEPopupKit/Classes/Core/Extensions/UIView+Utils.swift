//
//  UIView+Utils.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit
import QuickLayout

extension UILabel {
    var style: BEEProperty.LabelStyle {
        set {
            font = newValue.font
            textColor = newValue.color(for: traitCollection)
            textAlignment = newValue.alignment
            numberOfLines = newValue.numberOfLines
        }
        get {
            return BEEProperty.LabelStyle(font: font,
                                         color: BEEColor(textColor),
                                         alignment: textAlignment,
                                         numberOfLines: numberOfLines)
        }
    }

    var content: BEEProperty.LabelContent {
        set {
            text = newValue.text
            style = newValue.style
            if let attributeText = newValue.attributedText {
                attributedText = attributeText
            }
            accessibilityIdentifier = newValue.accessibilityIdentifier
        }
        get {
            return BEEProperty.LabelContent(text: text ?? "", style: style)
        }
    }
}

extension UIButton {
    var buttonContent: BEEProperty.ButtonContent {
        set {
            setTitle(newValue.label.text, for: .normal)
            setTitleColor(newValue.label.style.color(for: traitCollection), for: .normal)
            titleLabel?.font = newValue.label.style.font
            accessibilityIdentifier = newValue.accessibilityIdentifier
            backgroundColor = newValue.backgroundColor.color(
                for: traitCollection,
                mode: newValue.displayMode
            )
        }
        get {
            fatalError("buttonContent doesn't have a getter")
        }
    }
}

extension UIImageView {
    var imageContent: BEEProperty.ImageContent {
        set {
            stopAnimating()
            if newValue.images.count == 1 {
                image = newValue.images.first
            } else {
                animationImages = newValue.images.map {
                    $0.withRenderingMode(.alwaysTemplate)
                }
                animationDuration = newValue.imageSequenceAnimationDuration
            }

            contentMode = newValue.contentMode
            tintColor = newValue.tint?.color(for: traitCollection,
                                             mode: newValue.displayMode)
            accessibilityIdentifier = newValue.accessibilityIdentifier

            if let size = newValue.size {
                set(.width, of: size.width)
                set(.height, of: size.height)
            } else {
                forceContentWrap()
            }

            if newValue.makesRound {
                clipsToBounds = true
                if let size = newValue.size {
                    layer.cornerRadius = min(size.width, size.height) * 0.5
                } else {
                    layoutIfNeeded()
                    layer.cornerRadius = min(bounds.width, bounds.height) * 0.5
                }
            }

            startAnimating()

            if case .animate(duration: let duration,
                             options: let options,
                             transform: let transform) = newValue.animation {
                let options: UIView.AnimationOptions = [.repeat, .autoreverse, options]
                // A hack that forces the animation to run on the main thread,
                // on one of the next run loops
                DispatchQueue.main.async {
                    UIView.animate(withDuration: duration,
                                   delay: 0,
                                   options: options,
                                   animations: {
                        self.transform = transform
                    }, completion: nil)
                }
            }
        }
        get {
            fatalError("imageContent doesn't have a getter")
        }
    }
}

extension UITextField {

    var placeholder: BEEProperty.LabelContent {
        set {
            attributedPlaceholder = NSAttributedString(
                string: newValue.text,
                attributes: [
                    .font: newValue.style.font,
                    .foregroundColor: newValue.style.color(for: traitCollection)
                ]
            )
        }
        get {
            fatalError("placeholder doesn't have a getter")
        }
    }

    var textFieldContent: BEEProperty.TextFieldContent {
        set {
            placeholder = newValue.placeholder
            keyboardType = newValue.keyboardType
            textColor = newValue.textStyle.color(for: traitCollection)
            font = newValue.textStyle.font
            textAlignment = newValue.textStyle.alignment
            isSecureTextEntry = newValue.isSecure
            text = newValue.textContent
            tintColor = newValue.tintColor(for: traitCollection)
            accessibilityIdentifier = newValue.accessibilityIdentifier
        }
        get {
            fatalError("textFieldContent doesn't have a getter")
        }
    }
}


extension UIView {
    struct AssociatedKey {
        static var bee_popups_key: Void?
    }
    var popups: [BEEPopup] {
        set { objc_setAssociatedObject(self, &AssociatedKey.bee_popups_key, newValue, .OBJC_ASSOCIATION_RETAIN) }
        get { objc_getAssociatedObject(self, &AssociatedKey.bee_popups_key) as? [BEEPopup] ?? [] }
    }
}
