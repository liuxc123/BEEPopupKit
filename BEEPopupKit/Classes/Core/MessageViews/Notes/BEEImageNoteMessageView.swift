//
//  BEEImageNoteMessageView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

public class BEEImageNoteMessageView: BEEAccessoryNoteMessageView {

    // MARK: Setup
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(with content: BEEProperty.LabelContent, imageContent: BEEProperty.ImageContent) {
        super.init(frame: UIScreen.main.bounds)
        setup(with: content, imageContent: imageContent)
    }

    private func setup(with content: BEEProperty.LabelContent, imageContent: BEEProperty.ImageContent) {
        let imageView = UIImageView()
        imageView.imageContent = imageContent
        accessoryView = imageView
        super.setup(with: content)
    }
}

