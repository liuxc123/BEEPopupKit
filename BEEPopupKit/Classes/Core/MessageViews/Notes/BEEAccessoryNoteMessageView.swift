//
//  BEEAccessoryNoteMessageView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

public class BEEAccessoryNoteMessageView: UIView {

    // MARK: Props
    private let contentView = UIView()
    private var noteMessageView: BEENoteMessageView!
    var accessoryView: UIView!

    func setup(with content: BEEProperty.LabelContent) {
        clipsToBounds = true

        addSubview(contentView)
        contentView.layoutToSuperview(.centerX, .top, .bottom)
        contentView.layoutToSuperview(.left, relation: .greaterThanOrEqual, offset: 16)
        contentView.layoutToSuperview(.right, relation: .lessThanOrEqual, offset: -16)

        noteMessageView = BEENoteMessageView(with: content)
        noteMessageView.horizontalOffset = 8
        noteMessageView.verticalOffset = 7
        contentView.addSubview(noteMessageView)
        noteMessageView.layoutToSuperview(.top, .bottom, .trailing)

        contentView.addSubview(accessoryView)
        accessoryView.layoutToSuperview(.leading, .centerY)
        accessoryView.layout(.trailing, to: .leading, of: noteMessageView)
    }
}

