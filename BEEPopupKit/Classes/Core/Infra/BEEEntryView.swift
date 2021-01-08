//
//  BEEEntryView.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import UIKit
import QuickLayout

class BEEEntryView: BEEStyleView {

    struct Content {
        var viewController: UIViewController!
        var view: UIView!
        var attributes: BEEAttributes

        init(viewController: UIViewController, attributes: BEEAttributes) {
            self.viewController = viewController
            self.view = viewController.view
            self.attributes = attributes
        }

        init(view: UIView, attributes: BEEAttributes) {
            self.view = view
            self.attributes = attributes
        }
    }

    // MARK: Props

    /** Background view */
    private var backgroundView: BEEBackgroundView!

    /** The content - contains the view, view controller, attributes */
    var content: Content

    private lazy var contentView: UIView = {
        return UIView()
    }()

    var attributes: BEEAttributes {
        return content.attributes
    }

    private lazy var contentContainerView: BEEStyleView = {
        let contentContainerView = BEEStyleView()
        self.addSubview(contentContainerView)
        contentContainerView.layoutToSuperview(axis: .vertically)
        contentContainerView.layoutToSuperview(axis: .horizontally)
        contentContainerView.clipsToBounds = true
        return contentContainerView
    }()

    // MARK: Setup
    init(newEntry content: Content) {
        self.content = content
        super.init(frame: UIScreen.main.bounds)
        setupContentView()
        applyDropShadow()
        applyBackgroundToContentView()
        applyFrameStyle()
        adjustInnerContentAppearanceIfNeeded()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyFrameStyle()
    }

    func transform(to view: UIView) {

        let previousView = content.view
        content.view = view
        view.layoutIfNeeded()

        let previousHeight = set(.height, of: frame.height, priority: .must)
        let nextHeight = set(.height, of: view.frame.height, priority: .defaultLow)

        BEEPopupKit.layoutIfNeeded()

        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.beginFromCurrentState, .layoutSubviews], animations: {

            previousHeight.priority = .defaultLow
            nextHeight.priority = .must

            previousView!.alpha = 0

            BEEPopupKit.layoutIfNeeded()

        }, completion: { (finished) in

            view.alpha = 0

            previousView!.removeFromSuperview()
            self.removeConstraints([previousHeight, nextHeight])

            self.setupContentView()

            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
                view.alpha = 1
            }, completion: nil)
        })
    }

    private func setupContentView() {
        contentView.addSubview(content.view)
        content.view.layoutToSuperview(axis: .horizontally)
        content.view.layoutToSuperview(axis: .vertically)

        contentContainerView.addSubview(contentView)
        contentView.fillSuperview()
        contentView.layoutToSuperview(axis: .vertically)
        contentView.layoutToSuperview(axis: .horizontally)
    }

    // Complementary logic for issue #117
    private func adjustInnerContentAppearanceIfNeeded() {
        guard let view = content.view as? EntryAppearanceDescriptor else {
            return
        }
        view.bottomCornerRadius = attributes.roundCorners.cornerValues?.radius ?? 0
    }

    // Apply round corners
    private func applyFrameStyle() {
        backgroundView.applyFrameStyle(roundCorners: attributes.roundCorners, border: attributes.border)
    }

    // Apply drop shadow
    private func applyDropShadow() {
        switch attributes.shadow {
        case .active(with: let value):
            applyDropShadow(withOffset: value.offset,
                            opacity: value.opacity,
                            radius: value.radius,
                            color: value.color.color(for: traitCollection, mode: attributes.displayMode))
        case .none:
            removeDropShadow()
        }
    }

    // Apply background
    private func applyBackgroundToContentView() {
        let attributes = content.attributes

        let backgroundView = BEEBackgroundView()
        backgroundView.style = .init(background: attributes.entryBackground,
                                     displayMode: attributes.displayMode)

        switch attributes.positionConstraints.safeArea {
        case .empty(fillSafeArea: let fillSafeArea) where fillSafeArea: // Safe area filled with color
            insertSubview(backgroundView, at: 0)
            backgroundView.layoutToSuperview(axis: .horizontally)

            var topInset: CGFloat = 0
            var bottomInset: CGFloat = 0
            switch attributes.position {
            case .top, .topLeft, .topRight:
                topInset = -BEEWindowProvider.safeAreaInsets.top
            case .bottom, .bottomLeft, .bottomRight, .center, .centerLeft, .centerRight:
                bottomInset = BEEWindowProvider.safeAreaInsets.bottom
            }

            backgroundView.layoutToSuperview(.top, offset: topInset)
            backgroundView.layoutToSuperview(.bottom, offset: bottomInset)
        default: // Float case or a Toast with unfilled safe area
            contentView.insertSubview(backgroundView, at: 0)
            backgroundView.fillSuperview()
        }

        self.backgroundView = backgroundView
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        applyDropShadow()
    }
}

