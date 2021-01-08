//
//  BEEWindow.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

class BEEWindow: UIWindow {

    var isAbleToReceiveTouches = false

    init(with rootVC: UIViewController) {
        if #available(iOS 13.0, *) {
            // TODO: Patched to support SwiftUI out of the box but should require attendance
            if let scene = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).first as? UIWindowScene {
                super.init(windowScene: scene)
            } else {
                super.init(frame: UIScreen.main.bounds)
            }
        } else {
            super.init(frame: UIScreen.main.bounds)
        }
        backgroundColor = .clear
        rootViewController = rootVC
        accessibilityViewIsModal = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isAbleToReceiveTouches {
            return super.hitTest(point, with: event)
        }

        guard let rootVC = BEEWindowProvider.shared.rootVC else {
            return nil
        }

        if let view = rootVC.view.hitTest(point, with: event) {
            return view
        }

        return nil
    }
}
