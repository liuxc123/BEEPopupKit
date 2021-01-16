//
//  BEEAlertMessageView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

final public class BEEAlertMessageView: UIView, EntryAppearanceDescriptor {

    // MARK: Props

    var headerView: BEEAlertHeaderView!
    var headerSeparatorView: UIView!

    var buttonBarView: BEEButtonBarView!
    var customActionSequenceView: UIView?
    var buttonStackView: UIStackView!
    var buttonScrollView: UIScrollView!

    var contentStackView: UIStackView!

    let cancelSpaceView = UIView()
    var cancelButtonBarView: BEEButtonBarView!
    var cancelStackView: UIStackView!

    private let defaultCancelSpaceContent = BEEProperty.SpaceContent(backgroundColor: BEEColor(UIColor(hex6: 0xCCCCCC)), height: 10)
    private let message: BEEAlertMessage

    // MARK: EntryAppearenceDescriptor

    var bottomCornerRadius: CGFloat = 0 {
        didSet {
//            buttonBarView.bottomCornerRadius = bottomCornerRadius
        }
    }

    // MARK: Setup
    public init(with message: BEEAlertMessage) {
        self.message = message
        super.init(frame: UIScreen.main.bounds)

        setupContentStackView()

        setupHeaderView(with: message)
        setupHeaderSeparatorView(with: message.buttonBarContent)

        setupButtonScrollView()
        setupButtonStackView()
        setupButtonBarView(with: message.buttonBarContent)
        setupCustomActionSequenceView(with: message.customAction)

        setupCancelStackView()
        setupCancelSpaceView(with: message.cancelSpaceContent)
        setupCancelButtonBarView(with: message.cancelButtonBarContent)

        layoutContent(with: message)
        setupInterfaceStyle()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupContentStackView() {
        contentStackView = UIStackView()
        contentStackView.clipsToBounds = true
        contentStackView.axis = .vertical
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill
        addSubview(contentStackView)
    }

    private func setupHeaderView(with message: BEEAlertMessage) {
        headerView = BEEAlertHeaderView(with: message)
        contentStackView.addArrangedSubview(headerView)
    }

    private func setupHeaderSeparatorView(with content: BEEProperty.ButtonBarContent) {
        headerSeparatorView = UIView()
        headerSeparatorView.set(.height, of: 1.0)
        headerSeparatorView.backgroundColor = content.separatorColor.color(for: traitCollection, mode: content.displayMode)
        contentStackView.addArrangedSubview(headerSeparatorView)
    }

    private func setupButtonScrollView() {
        buttonScrollView = UIScrollView()
        buttonScrollView.bounces = false
        contentStackView.addArrangedSubview(buttonScrollView)
    }

    private func setupButtonStackView() {
        buttonStackView = UIStackView()
        buttonStackView.clipsToBounds = true
        buttonStackView.axis = .vertical
        buttonScrollView.addSubview(buttonStackView)
    }

    private func setupButtonBarView(with content: BEEProperty.ButtonBarContent) {
        buttonBarView = BEEButtonBarView(with: content)
        buttonBarView.clipsToBounds = true
        buttonStackView.addArrangedSubview(buttonBarView)
    }

    private func setupCustomActionSequenceView(with content: BEEProperty.CustomContent?) {
        guard let content = content else {
            return
        }
        customActionSequenceView = content.view
        buttonStackView.addArrangedSubview(customActionSequenceView!)
    }

    private func setupCancelStackView() {
        cancelStackView = UIStackView()
        cancelStackView.clipsToBounds = true
        cancelStackView.axis = .vertical
        addSubview(cancelStackView)
    }

    private func setupCancelSpaceView(with content: BEEProperty.SpaceContent?) {
        let content = content ?? defaultCancelSpaceContent
        cancelSpaceView.backgroundColor = content.backgroundColor(for: traitCollection)
        cancelSpaceView.clipsToBounds = true
        cancelStackView.addArrangedSubview(cancelSpaceView)
    }

    private func setupCancelButtonBarView(with content: BEEProperty.ButtonBarContent?) {
        let content = content ?? BEEProperty.ButtonBarContent(with: [], separatorColor: .clear)
        cancelButtonBarView = BEEButtonBarView(with: content)
        cancelButtonBarView.clipsToBounds = true
        cancelStackView.addArrangedSubview(cancelButtonBarView)
    }

    func layoutContent(with message: BEEAlertMessage) {
        contentStackView.layoutToSuperview(.top, .left, .right, .width)

//        headerView.set(.height, of: 400, relation: .equal, ratio: 1.0, priority: .required)


        buttonStackView.layoutToSuperview(.top, .bottom, .left, .right, .width)
        buttonStackView.layoutToSuperview(.height)?.priority = .defaultHigh
        buttonBarView.expand()

        cancelStackView.layout(.top, to: .bottom, of: contentStackView)
        cancelStackView.layoutToSuperview(.bottom, .left, .right)
        cancelSpaceView.set(.height, of: (message.cancelSpaceContent ?? defaultCancelSpaceContent).height)
        cancelSpaceView.isHidden = message.cancelButtonBarContent == nil
        cancelButtonBarView.isHidden = message.cancelButtonBarContent == nil
        cancelButtonBarView.expand()
    }

    private func setupInterfaceStyle() {
        self.headerSeparatorView.backgroundColor = message.buttonBarContent.separatorColor.color(for: traitCollection, mode: message.displayMode)
        self.backgroundColor = message.backgroundColor?.color(for: traitCollection, mode: message.displayMode)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupInterfaceStyle()
    }
}

