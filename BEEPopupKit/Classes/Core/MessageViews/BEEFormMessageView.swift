//
//  BEEFormMessageView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

final public class BEEFormMessageView: UIView {

    private let scrollViewVerticalOffset: CGFloat = 20

    // MARK: Props

    private let titleLabel = UILabel()
    private let scrollView = UIScrollView()
    private let textFieldsContent: [BEEProperty.TextFieldContent]
    private var textFieldViews: [BEETextField] = []
    private var buttonBarView: BEEButtonBarView!

    private let titleContent: BEEProperty.LabelContent

    // MARK: Setup

    public init(with title: BEEProperty.LabelContent,
                textFieldsContent: [BEEProperty.TextFieldContent],
                buttonContent: BEEProperty.ButtonContent) {
        self.titleContent = title
        self.textFieldsContent = textFieldsContent
        super.init(frame: UIScreen.main.bounds)
        setupScrollView()
        setupTitleLabel()
        setupTextFields(with: textFieldsContent)
        setupButton(with: buttonContent)
        setupTapGestureRecognizer()
        scrollView.layoutIfNeeded()
        set(.height,
            of: scrollView.contentSize.height + scrollViewVerticalOffset * 2,
            priority: .defaultHigh)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextFields(with textFieldsContent: [BEEProperty.TextFieldContent]) {
        var textFieldIndex = 0
        textFieldViews = textFieldsContent.map { content -> BEETextField in
            let textField = BEETextField(with: content)
            scrollView.addSubview(textField)
            textField.tag = textFieldIndex
            textFieldIndex += 1
            return textField
        }
        textFieldViews.first!.layout(.top, to: .bottom, of: titleLabel, offset: 20)
        textFieldViews.spread(.vertically, offset: 5)
        textFieldViews.layoutToSuperview(axis: .horizontally)
    }

    // Setup tap gesture
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(tapGestureRecognized)
        )
        tapGestureRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapGestureRecognizer)
    }

    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.layoutToSuperview(axis: .horizontally, offset: 20)
        scrollView.layoutToSuperview(axis: .vertically, offset: scrollViewVerticalOffset)
        scrollView.layoutToSuperview(.width, .height, offset: -scrollViewVerticalOffset * 2)
    }

    private func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.layoutToSuperview(.top, .width)
        titleLabel.layoutToSuperview(axis: .horizontally)
        titleLabel.forceContentWrap(.vertically)
        titleLabel.content = titleContent
    }

    private func setupButton(with buttonContent: BEEProperty.ButtonContent) {
        var buttonContent = buttonContent
        let action = buttonContent.action
        buttonContent.action = { [weak self] in
            self?.extractTextFieldsContent()
            action?()
        }
        let buttonsBarContent = BEEProperty.ButtonBarContent(
            with: buttonContent,
            separatorColor: .clear
        )
        buttonBarView = BEEButtonBarView(with: buttonsBarContent)
        buttonBarView.clipsToBounds = true
        scrollView.addSubview(buttonBarView)
        buttonBarView.expand()
        buttonBarView.layout(.top, to: .bottom, of: textFieldViews.last!, offset: 20)
        buttonBarView.layoutToSuperview(.centerX)
        buttonBarView.layoutToSuperview(.width, offset: -40)
        buttonBarView.layoutToSuperview(.bottom)
        buttonBarView.layer.cornerRadius = 5
    }

    private func extractTextFieldsContent() {
        for (content, textField) in zip(textFieldsContent, textFieldViews) {
            content.contentWrapper.text = textField.text
        }
    }

    /** Makes a specific text field the first responder */
    public func becomeFirstResponder(with textFieldIndex: Int) {
        textFieldViews[textFieldIndex].makeFirstResponder()
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        titleLabel.textColor = titleContent.style.color(for: traitCollection)
    }

    // MARK: User Intractions

    // Tap Gesture
    @objc func tapGestureRecognized() {
        endEditing(true)
    }
}

