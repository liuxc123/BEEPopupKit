//
//  BEEMessageContentView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit
import QuickLayout

public class BEEMessageContentView: UIView {

    // MARK: Properties

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private var horizontalConstraints: QLAxisConstraints!
    private var topConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    private var labelsOffsetConstraint: NSLayoutConstraint!

    public var titleContent: BEEProperty.LabelContent! {
        didSet {
            titleLabel.content = titleContent
        }
    }

    public var subtitleContent: BEEProperty.LabelContent! {
        didSet {
            subtitleLabel.content = subtitleContent
        }
    }

    public var titleAttributes: BEEProperty.LabelStyle! {
        didSet {
            titleLabel.style = titleAttributes
        }
    }

    public var subtitleAttributes: BEEProperty.LabelStyle! {
        didSet {
            subtitleLabel.style = subtitleAttributes
        }
    }

    public var title: String! {
        didSet {
            titleLabel.text = title
        }
    }

    public var subtitle: String! {
        didSet {
            subtitleLabel.text = subtitle
        }
    }

    public var verticalMargins: CGFloat = 20 {
        didSet {
            topConstraint.constant = verticalMargins
            bottomConstraint.constant = -verticalMargins
            layoutIfNeeded()
        }
    }

    public var horizontalMargins: CGFloat = 20 {
        didSet {
            horizontalConstraints.first.constant = horizontalMargins
            horizontalConstraints.second.constant = -horizontalMargins
            layoutIfNeeded()
        }
    }

    public var labelsOffset: CGFloat = 8 {
        didSet {
            labelsOffsetConstraint.constant = labelsOffset
            layoutIfNeeded()
        }
    }

    // MARK: Setup

    public init() {
        super.init(frame: UIScreen.main.bounds)
        clipsToBounds = true
        setupTitleLabel()
        setupSubtitleLabel()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTitleLabel() {
        addSubview(titleLabel)
        topConstraint = titleLabel.layoutToSuperview(.top, offset: verticalMargins)
        horizontalConstraints = titleLabel.layoutToSuperview(axis: .horizontally, offset: horizontalMargins)
        titleLabel.forceContentWrap(.vertically)
    }

    private func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        labelsOffsetConstraint = subtitleLabel.layout(.top, to: .bottom, of: titleLabel, offset: labelsOffset)
        subtitleLabel.layout(to: .left, of: titleLabel)
        subtitleLabel.layout(to: .right, of: titleLabel)
        bottomConstraint = subtitleLabel.layoutToSuperview(.bottom, offset: -verticalMargins, priority: .must)
        subtitleLabel.forceContentWrap(.vertically)
    }

    private func setupInterfaceStyle() {
        titleLabel.textColor = titleContent?.style.color(for: traitCollection)
        subtitleLabel.textColor = subtitleContent?.style.color(for: traitCollection)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupInterfaceStyle()
    }
}

