//
//  BEEWrapperView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

class BEEWrapperView: UIView {
    var isAbleToReceiveTouches = false
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isAbleToReceiveTouches {
            return super.hitTest(point, with: event)
        }
        if let view = super.hitTest(point, with: event), view != self {
            return view
        }
        return nil
    }
}
