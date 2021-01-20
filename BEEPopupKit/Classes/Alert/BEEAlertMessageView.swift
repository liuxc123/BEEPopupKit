//
//  BEEAlertMessageView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

final public class BEEAlertMessageView: UIView {

    // MARK: Props

    private var headerView: BEEAlertHeaderView!
    private var headerSeparatorView: UIView!
    private var headerContentView: UIView!

    private var buttonBarView: BEEButtonBarView!
    private var customActionSequenceView: UIView?
    private var buttonStackView: UIStackView!
    private var buttonScrollView: UIScrollView!

    private var contentStackView: UIStackView!

    private let cancelSpaceView = UIView()
    private var cancelButtonBarView: BEEButtonBarView!
    private var cancelStackView: UIStackView!

    private var headerMaxHeightConstraint: NSLayoutConstraint!
    private var headerMaxHeight: CGFloat {
        return (UIScreen.main.bounds.size.height * 0.9) / 2
    }

    private let defaultCancelSpaceContent = BEEProperty.SpaceContent(backgroundColor: BEEColor(UIColor(hex6: 0xCCCCCC)), height: 10)
    private let message: BEEAlertMessage

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
        headerContentView = UIView()
        headerContentView.clipsToBounds = true
        contentStackView.addArrangedSubview(headerContentView)

        headerView = BEEAlertHeaderView(with: message)
        headerContentView.addSubview(headerView)
    }

    private func setupHeaderSeparatorView(with content: BEEProperty.ButtonBarContent) {
        headerSeparatorView = UIView()
        headerSeparatorView.set(.height, of: 1.0)
        headerSeparatorView.backgroundColor = content.separatorColor.color(for: traitCollection, mode: content.displayMode)
        contentStackView.addArrangedSubview(headerSeparatorView)
    }

    private func setupButtonScrollView() {
        buttonScrollView = UIScrollView()
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
        buttonBarView.separatorViews.first?.isHidden = true
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

        headerView.layoutToSuperview(.top, .left, .right, .bottom)
        headerMaxHeightConstraint = headerContentView.set(.height, of: headerMaxHeight, relation: .lessThanOrEqual, ratio: 1.0, priority: .defaultHigh)

        buttonStackView.layoutToSuperview(.top, .bottom, .left, .right, .width)
        buttonStackView.layoutToSuperview(.height)?.priority = .defaultHigh
        buttonBarView.expand()

        cancelStackView.layout(.top, to: .bottom, of: contentStackView)
        cancelStackView.layoutToSuperview(.bottom, .left, .right)
        cancelSpaceView.set(.height, of: (message.cancelSpaceContent ?? defaultCancelSpaceContent).height)

        cancelSpaceView.isHidden = message.cancelButtonBarContent?.content.isEmpty ?? true
        cancelButtonBarView.isHidden = message.cancelButtonBarContent?.content.isEmpty ?? true
        cancelButtonBarView.expand()
    }

    private func setupInterfaceStyle() {
        self.headerSeparatorView?.backgroundColor = message.buttonBarContent.separatorColor.color(for: traitCollection, mode: message.displayMode)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupInterfaceStyle()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        headerMaxHeightConstraint.constant = headerMaxHeight
    }
}

