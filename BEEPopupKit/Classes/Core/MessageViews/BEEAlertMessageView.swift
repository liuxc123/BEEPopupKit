//
//  BEEAlertMessageView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

final public class BEEAlertMessageView: BEESimpleMessageView, EntryAppearanceDescriptor {

    // MARK: Props
    var buttonBarView: BEEButtonBarView!
    let cancelSpaceView = UIView()
    var cancelButtonBarView: BEEButtonBarView!
    let defaultCancelSpaceContent = BEEProperty.SpaceContent(backgroundColor: BEEColor(UIColor(hex6: 0xCCCCCC)), height: 10)

    // MARK: EntryAppearenceDescriptor

    var bottomCornerRadius: CGFloat = 0 {
        didSet {
            buttonBarView.bottomCornerRadius = bottomCornerRadius
        }
    }

    // MARK: Setup
    public init(with message: BEEAlertMessage) {
        super.init(with: message.simpleMessage)
        setupButtonBarView(with: message.buttonBarContent)
        setupCancelSpaceView(with: message.cancelSpaceContent)
        setupCancelButtonBarView(with: message.cancelButtonBarContent)
        layoutContent(with: message)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButtonBarView(with content: BEEProperty.ButtonBarContent) {
        buttonBarView = BEEButtonBarView(with: content)
        buttonBarView.clipsToBounds = true
        addSubview(buttonBarView)
    }

    private func setupCancelSpaceView(with content: BEEProperty.SpaceContent?) {
        let content = content ?? defaultCancelSpaceContent
        cancelSpaceView.backgroundColor = content.backgroundColor(for: traitCollection)
        cancelSpaceView.clipsToBounds = true
        addSubview(cancelSpaceView)
    }

    private func setupCancelButtonBarView(with content: BEEProperty.ButtonBarContent?) {
        let content = content ?? BEEProperty.ButtonBarContent(with: [], separatorColor: .clear)
        cancelButtonBarView = BEEButtonBarView(with: content)
        cancelButtonBarView.clipsToBounds = true
        addSubview(cancelButtonBarView)
    }

    func layoutContent(with message: BEEAlertMessage) {
        switch message.imagePosition {
        case .top:
            messageContentView.verticalMargins = 16
            messageContentView.horizontalMargins = 16
            messageContentView.labelsOffset = 5

            if let thumbImageView = thumbImageView {
                thumbImageView.layoutToSuperview(.top, offset: 20)
                thumbImageView.layoutToSuperview(.centerX)
                messageContentView.layout(.top, to: .bottom, of: thumbImageView)
            } else {
                messageContentView.layoutToSuperview(.top)
            }

            messageContentView.layoutToSuperview(axis: .horizontally)
            buttonBarView.layout(.top, to: .bottom, of: messageContentView)
        case .left:
            messageContentView.verticalMargins = 0
            messageContentView.horizontalMargins = 0
            messageContentView.labelsOffset = 5

            if let thumbImageView = thumbImageView {
                thumbImageView.layoutToSuperview(.top, .left, offset: 16)
                messageContentView.layout(.left, to: .right, of: thumbImageView, offset: 12)
                messageContentView.layout(to: .top, of: thumbImageView, offset: 2)
            } else {
                messageContentView.layoutToSuperview(.left, .top, offset: 16)
            }

            messageContentView.layoutToSuperview(.right, offset: -16)
            buttonBarView.layout(.top, to: .bottom, of: messageContentView, offset: 10)
        }

        buttonBarView.layoutToSuperview(axis: .horizontally)
        buttonBarView.expand()

        let hasCancelButton = message.cancelButtonBarContent?.content.isEmpty ?? false

        if hasCancelButton {

        }

        if (message.cancelButtonBarContent?.content.isEmpty ?? true) {
            buttonBarView.layoutToSuperview(.bottom)
        } else {
            cancelSpaceView.layout(.top, to: .bottom, of: buttonBarView)
            cancelSpaceView.set(.height, of: (message.cancelSpaceContent ?? defaultCancelSpaceContent).height)
            cancelSpaceView.layoutToSuperview(axis: .horizontally)

            cancelButtonBarView.layout(.top, to: .bottom, of: cancelSpaceView)
            cancelButtonBarView.layoutToSuperview(axis: .horizontally)
            cancelButtonBarView.layoutToSuperview(.bottom)
            cancelButtonBarView.expand()
        }
    }
}

