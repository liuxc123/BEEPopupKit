//
//  BEENoteMessageView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit
import QuickLayout

public class BEENoteMessageView: UIView {

    // MARK: Props
    private let label = UILabel()

    private var horizontalConstrainsts: QLAxisConstraints!
    private var verticalConstrainsts: QLAxisConstraints!

    public var horizontalOffset: CGFloat = 10 {
        didSet {
            horizontalConstrainsts.first.constant = horizontalOffset
            horizontalConstrainsts.second.constant = -horizontalOffset
            layoutIfNeeded()
        }
    }

    public var verticalOffset: CGFloat = 5 {
        didSet {
            verticalConstrainsts.first.constant = verticalOffset
            verticalConstrainsts.second.constant = -verticalOffset
            layoutIfNeeded()
        }
    }

    // MARK: Setup
    public init(with content: BEEProperty.LabelContent) {
        super.init(frame: UIScreen.main.bounds)
        setup(with: content)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(with content: BEEProperty.LabelContent) {
        clipsToBounds = true
        addSubview(label)
        label.content = content
        horizontalConstrainsts = label.layoutToSuperview(axis: .horizontally, offset: horizontalOffset, priority: .must)
        verticalConstrainsts = label.layoutToSuperview(axis: .vertically, offset: verticalOffset, priority: .must)
    }
}

