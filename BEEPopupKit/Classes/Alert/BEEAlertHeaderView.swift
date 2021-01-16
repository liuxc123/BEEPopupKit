//
//  BEEAlertHeaderView.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/16.
//

import UIKit

class BEEAlertHeaderView: UIScrollView {

    var contentView: UIView!

    var thumbImageView: UIImageView!
    let messageContentView = BEEMessageContentView()
    var customHeaderView: UIView?
    var thumbStackView: UIStackView!
    var headerStackView: UIStackView!

    private let message: BEEAlertMessage

    public init(with message: BEEAlertMessage) {
        self.message = message
        super.init(frame: UIScreen.main.bounds)
        setupContainerViews()

        setupThumbImageView(with: message.image)
        setupMessageContentView(with: message.title, description: message.description)
        setupCustomHeaderView(with: message.custom)

        layoutContent(with: message)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupContainerViews() {

        contentView = UIView()
        addSubview(contentView)

        thumbStackView = UIStackView()
        thumbStackView.clipsToBounds = true
        thumbStackView.alignment = .center
        thumbStackView.axis = .vertical
        contentView.addSubview(thumbStackView)

        headerStackView = UIStackView()
        headerStackView.clipsToBounds = true
        headerStackView.axis = .vertical
        contentView.addSubview(headerStackView)
    }

    private func setupThumbImageView(with content: BEEProperty.ImageContent?) {
        guard let content = content else {
            return
        }
        thumbImageView = UIImageView()
        thumbImageView.imageContent = content
        thumbStackView.addArrangedSubview(thumbImageView)
    }

    private func setupMessageContentView(with title: BEEProperty.LabelContent,
                                         description: BEEProperty.LabelContent) {
        messageContentView.titleContent = title
        messageContentView.subtitleContent = description
        headerStackView.addArrangedSubview(messageContentView)
    }

    private func setupCustomHeaderView(with content: BEEProperty.CustomContent?) {
        guard let content = content else {
            return
        }
        customHeaderView = content.view
        headerStackView.addArrangedSubview(customHeaderView!)
    }

    private func layoutContent(with message: BEEAlertMessage) {
        contentView.layoutToSuperview(.top, .bottom, .left, .right, .width)
        contentView.layoutToSuperview(.height)?.priority = .defaultHigh

        thumbStackView.layoutToSuperview(.top, offset: 20)
        thumbStackView.layoutToSuperview(.centerX)

        headerStackView.layout(.top, to: .bottom, of: thumbStackView)
        headerStackView.layoutToSuperview(.left, offset: 16)
        headerStackView.layoutToSuperview(.right, offset: -16)
        headerStackView.layoutToSuperview(.bottom)

        messageContentView.verticalMargins = 16
        messageContentView.horizontalMargins = 16
        messageContentView.labelsOffset = 5
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let originalSize = contentSize
        contentSize = CGSize(width: originalSize.width, height: min(originalSize.height, 400))
    }

}
