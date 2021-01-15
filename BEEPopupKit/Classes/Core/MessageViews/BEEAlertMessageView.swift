//
//  BEEAlertMessageView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

final public class BEEAlertMessageView: UIView, EntryAppearanceDescriptor {

    // MARK: Props
    var thumbStackView: UIStackView!
    var headerStackView: UIStackView!
    var buttonStackView: UIStackView!

    var thumbImageView: UIImageView!
    let messageContentView = BEEMessageContentView()
    var customView: UIView?
    var buttonBarView: BEEButtonBarView!
    let cancelSpaceView = UIView()
    var cancelButtonBarView: BEEButtonBarView!
    let defaultCancelSpaceContent = BEEProperty.SpaceContent(backgroundColor: BEEColor(UIColor(hex6: 0xCCCCCC)), height: 10)

    private let message: BEEAlertMessage

    // MARK: EntryAppearenceDescriptor

    var bottomCornerRadius: CGFloat = 0 {
        didSet {
            buttonBarView.bottomCornerRadius = bottomCornerRadius
        }
    }

    // MARK: Setup
    public init(with message: BEEAlertMessage) {
        self.message = message
        super.init(frame: UIScreen.main.bounds)
        setupStackView()
        setupThumbImageView(with: message.image)
        setupMessageContentView(with: message.title, description: message.description)
        setupCustomContentView(with: message.custom)
        setupButtonBarView(with: message.buttonBarContent)
        setupCancelSpaceView(with: message.cancelSpaceContent)
        setupCancelButtonBarView(with: message.cancelButtonBarContent)
        layoutContent(with: message)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStackView() {

        thumbStackView = UIStackView()
        thumbStackView.clipsToBounds = true
        thumbStackView.alignment = .center
        thumbStackView.axis = .vertical
        addSubview(thumbStackView)

        headerStackView = UIStackView()
        headerStackView.clipsToBounds = true
        headerStackView.axis = .vertical
        addSubview(headerStackView)

        buttonStackView = UIStackView()
        buttonStackView.clipsToBounds = true
        buttonStackView.axis = .vertical
        addSubview(buttonStackView)
    }

    private func setupThumbImageView(with content: BEEProperty.ImageContent?) {
        thumbImageView = UIImageView()
        thumbStackView.addArrangedSubview(thumbImageView)
        guard let content = content else {
            return
        }
        thumbImageView.imageContent = content
    }

    private func setupMessageContentView(with title: BEEProperty.LabelContent,
                                         description: BEEProperty.LabelContent) {
        messageContentView.titleContent = title
        messageContentView.subtitleContent = description
        headerStackView.addArrangedSubview(messageContentView)
    }

    private func setupCustomContentView(with content: BEEProperty.CustomContent?) {
        guard let content = content else {
            return
        }
        customView = content.view
        headerStackView.addArrangedSubview(customView!)
    }

    private func setupButtonBarView(with content: BEEProperty.ButtonBarContent) {
        buttonBarView = BEEButtonBarView(with: content)
        buttonBarView.clipsToBounds = true
        buttonStackView.addArrangedSubview(buttonBarView)
    }

    private func setupCancelSpaceView(with content: BEEProperty.SpaceContent?) {
        let content = content ?? defaultCancelSpaceContent
        cancelSpaceView.backgroundColor = content.backgroundColor(for: traitCollection)
        cancelSpaceView.clipsToBounds = true
        buttonStackView.addArrangedSubview(cancelSpaceView)
    }

    private func setupCancelButtonBarView(with content: BEEProperty.ButtonBarContent?) {
        let content = content ?? BEEProperty.ButtonBarContent(with: [], separatorColor: .clear)
        cancelButtonBarView = BEEButtonBarView(with: content)
        cancelButtonBarView.clipsToBounds = true
        buttonStackView.addArrangedSubview(cancelButtonBarView)
    }

    func layoutContent(with message: BEEAlertMessage) {

        thumbStackView.layoutToSuperview(.top, offset: 20)
        thumbStackView.layoutToSuperview(.left, .right)

        headerStackView.layout(.top, to: .bottom, of: thumbImageView)
        headerStackView.layoutToSuperview(.left, offset: 16)
        headerStackView.layoutToSuperview(.right, offset: -16)

        buttonStackView.layout(.top, to: .bottom, of: headerStackView, offset: 10)
        buttonStackView.layoutToSuperview(.bottom, .left, .right)

        messageContentView.verticalMargins = 16
        messageContentView.horizontalMargins = 16
        messageContentView.labelsOffset = 5

        cancelSpaceView.set(.height, of: (message.cancelSpaceContent ?? defaultCancelSpaceContent).height)
        cancelSpaceView.isHidden = message.cancelButtonBarContent == nil
        cancelButtonBarView.isHidden = message.cancelButtonBarContent == nil

        buttonBarView.expand()
        cancelButtonBarView.expand()
    }

    private func setupInterfaceStyle() {
        self.backgroundColor = message.backgroundColor?.color(for: traitCollection, mode: message.displayMode)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupInterfaceStyle()
    }
}

