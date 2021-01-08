//
//  BEEXStatusBarMessageView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit
import QuickLayout

public class BEEXStatusBarMessageView: UIView {

    // MARK: Props
    private let leadingLabel = UILabel()
    private let trailingLabel = UILabel()

    // MARK: Setup
    public init(leading: BEEProperty.LabelContent, trailing: BEEProperty.LabelContent) {
        super.init(frame: UIScreen.main.bounds)
        setup(leading: leading, trailing: trailing)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(leading: BEEProperty.LabelContent, trailing: BEEProperty.LabelContent) {
        clipsToBounds = true

        set(.height, of: UIApplication.shared.statusBarFrame.maxY)

        addSubview(leadingLabel)
        leadingLabel.content = leading

        leadingLabel.layoutToSuperview(axis: .vertically)
        leadingLabel.layoutToSuperview(.leading)
        leadingLabel.layoutToSuperview(.width, ratio: 0.26)

        addSubview(trailingLabel)
        trailingLabel.content = trailing

        trailingLabel.layoutToSuperview(axis: .vertically)
        trailingLabel.layoutToSuperview(.trailing)
        trailingLabel.layoutToSuperview(.width, ratio: 0.26)
    }
}
