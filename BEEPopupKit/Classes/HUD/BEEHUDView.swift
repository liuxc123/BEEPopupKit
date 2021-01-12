//
//  BEEHUDView.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/12.
//

import UIKit
import QuickLayout

struct BEEHUDMessage {

    /** The image view descriptor */
    public let image: BEEProperty.ImageContent?

    /** The title label descriptor */
    public let title: BEEProperty.LabelContent

    public init(image: BEEProperty.ImageContent? = nil,
                title: BEEProperty.LabelContent) {
        self.image = image
        self.title = title
    }
}

class BEEHUDMessageView: UIView {
    
    // MARK: Props
    private var thumbImageView: UIImageView!
    private var label: UILabel!
    private let message: BEEHUDMessage!
    
    // MARK: Setup
    init(with message: BEEHUDMessage) {
        self.message = message
        super.init(frame: UIScreen.main.bounds)
        setupThumbImageView(with: message.image)
        setupLabel(with: message.title)
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

    private func setupLabel(with content: BEEProperty.LabelContent) {
        label = UILabel()
        label.content = content
        addSubview(label)
    }
    
    private func setupLayout(message: BEEHUDMessage) {
        thumbImageView.layoutToSuperview(.top, offset: 10)
        thumbImageView.layoutToSuperview(.centerX)
        label.layout(.top, to: .bottom, of: thumbImageView, offset: 10)
        label.layoutToSuperview(.bottom, offset: -10)
        label.layoutToSuperview(.left, offset: 10)
        label.layoutToSuperview(.right, offset: -10)
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
