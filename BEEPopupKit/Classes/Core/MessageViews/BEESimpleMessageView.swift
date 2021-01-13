//
//  BEESimpleMessageView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

public class BEESimpleMessageView: UIView {

    // MARK: Props
    var thumbImageView: UIImageView!
    let messageContentView = BEEMessageContentView()
    private let message: BEESimpleMessage

    // MARK: Setup
    init(with message: BEESimpleMessage) {
        self.message = message
        super.init(frame: UIScreen.main.bounds)
        setupThumbImageView(with: message.image)
        setupMessageContentView(with: message.title,
                                description: message.description)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupThumbImageView(with content: BEEProperty.ImageContent?) {
        guard let content = content else {
            return
        }
        thumbImageView = UIImageView()
        addSubview(thumbImageView)
        thumbImageView.imageContent = content
    }

    private func setupMessageContentView(with title: BEEProperty.LabelContent,
                                         description: BEEProperty.LabelContent) {
        messageContentView.titleContent = title
        messageContentView.subtitleContent = description
        addSubview(messageContentView)
    }

    private func setupInterfaceStyle() {
        if let image = message.image {
            thumbImageView?.tintColor = image.tint?.color(
                for: traitCollection,
                mode: image.displayMode
            )
        }

    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupInterfaceStyle()
    }
}

