//
//  BEEButtonView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

final class BEEButtonView: UIView {

    // MARK: - Properties

    private let button = UIButton()
    private let titleLabel = UILabel()

    private let content: BEEProperty.ButtonContent

    // MARK: - Setup

    init(content: BEEProperty.ButtonContent) {
        self.content = content
        super.init(frame: .zero)
        setupTitleLabel()
        setupButton()
        setupAcceessibility()
        setupInterfaceStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAcceessibility() {
        isAccessibilityElement = false
        button.isAccessibilityElement = true
        button.accessibilityIdentifier = content.accessibilityIdentifier
        button.accessibilityLabel = content.label.text
    }

    private func setupButton() {
        addSubview(button)
        button.fillSuperview()
        button.addTarget(self, action: #selector(buttonTouchUp),
                         for: [.touchUpInside, .touchUpOutside, .touchCancel])
        button.addTarget(self, action: #selector(buttonTouchDown),
                         for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUpInside),
                         for: .touchUpInside)
    }

    private func setupTitleLabel() {
        titleLabel.text = content.label.text
        titleLabel.numberOfLines = content.label.style.numberOfLines
        titleLabel.font = content.label.style.font
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        if let attributeText = content.label.attributedText {
            titleLabel.attributedText = attributeText
        }
        addSubview(titleLabel)
        titleLabel.layoutToSuperview(axis: .horizontally,
                                     offset: content.contentEdgeInset)
        titleLabel.layoutToSuperview(axis: .vertically,
                                     offset: content.contentEdgeInset)
    }

    private func setBackground(by content: BEEProperty.ButtonContent,
                               isHighlighted: Bool) {
        if isHighlighted {
            backgroundColor = content.highlightedBackgroundColor(for: traitCollection)
        } else {
            backgroundColor = content.backgroundColor(for: traitCollection)
        }
    }

    private func setupInterfaceStyle() {
        backgroundColor = content.backgroundColor(for: traitCollection)
        if content.label.attributedText == nil {
            titleLabel.textColor = content.label.style.color(for: traitCollection)
        }
    }

    // MARK: - Selectors

    @objc func buttonTouchUpInside() {
        content.action?()
    }

    @objc func buttonTouchDown() {
        setBackground(by: content, isHighlighted: true)
    }

    @objc func buttonTouchUp() {
        setBackground(by: content, isHighlighted: false)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupInterfaceStyle()
    }
}
