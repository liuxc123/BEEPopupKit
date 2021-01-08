//
//  BEERatingMessageView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit
import QuickLayout

final public class BEERatingMessageView: UIView, EntryAppearanceDescriptor {

    // MARK: Properties

    private var message: BEERatingMessage

    // MARK: EntryAppearenceDescriptor

    var bottomCornerRadius: CGFloat = 0 {
        didSet {
            buttonBarView.bottomCornerRadius = bottomCornerRadius
        }
    }

    private var selectedIndex: Int! {
        didSet {
            message.selectedIndex = selectedIndex
            let item = message.ratingItems[selectedIndex]
            set(title: item.title,
                description: item.description)
        }
    }

    private let messageContentView = BEEMessageContentView()
    private let symbolsView = BEERatingSymbolsContainerView()
    private var buttonBarView: BEEButtonBarView!

    public init(with message: BEERatingMessage) {
        self.message = message
        super.init(frame: UIScreen.main.bounds)
        setupMessageContentView()
        setupSymbolsView()
        setupButtonBarView()
        set(title: message.initialTitle,
            description: message.initialDescription)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func set(title: BEEProperty.LabelContent,
                     description: BEEProperty.LabelContent) {
        messageContentView.titleContent = title
        messageContentView.subtitleContent = description
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: [.transitionCrossDissolve],
                       animations: {
            BEEPopupKit.layoutIfNeeded()
        }, completion: nil)
    }

    private func setupMessageContentView() {
        addSubview(messageContentView)
        messageContentView.verticalMargins = 20
        messageContentView.horizontalMargins = 30
        messageContentView.layoutToSuperview(axis: .horizontally,
                                             priority: .must)
        messageContentView.layoutToSuperview(.top, offset: 10)
    }

    private func setupSymbolsView() {
        addSubview(symbolsView)
        symbolsView.setup(with: message) { [unowned self] (index: Int) in
            self.message.selectedIndex = index
            self.message.selection?(index)
            self.selectedIndex = index
            self.animateIn()
        }
        symbolsView.layoutToSuperview(.centerX)
        symbolsView.layout(.top,
                           to: .bottom,
                           of: messageContentView,
                           offset: 10,
                           priority: .must)
    }

    private func setupButtonBarView() {
        buttonBarView = BEEButtonBarView(with: message.buttonBarContent)
        buttonBarView.clipsToBounds = true
        buttonBarView.alpha = 0
        addSubview(buttonBarView)
        buttonBarView.layout(.top,
                             to: .bottom,
                             of: symbolsView,
                             offset: 30)
        buttonBarView.layoutToSuperview(.bottom)
        buttonBarView.layoutToSuperview(axis: .horizontally)
    }

    // MARK: - Internal Animation

    private func animateIn() {
        layoutIfNeeded()
        buttonBarView.expand()
    }
}

