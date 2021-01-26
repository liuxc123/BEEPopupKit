//
//  ViewController+Custom.swift
//  BEEPopupKit_Example
//
//  Created by liuxc on 2021/1/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BEEPopupKit

extension ViewController {

    @objc func customTest1() {

        var attributes = BEEAttributes.centerFloat
        attributes.displayDuration = .infinity
        attributes.precedence = .enqueue(priority: .high)
        attributes.screenBackground = .color(color: BEEColor(UIColor.black.withAlphaComponent(0.4)))
        attributes.entryBackground = .color(color: .white)
        attributes.entryInteraction = .absorbTouches
        attributes.screenInteraction = .dismiss
        attributes.positionConstraints.maxSize = .init(width: .ratio(value: 1.0), height: .ratio(value: 0.9))
        attributes.roundCorners = .all(radius: 15)
        attributes.entranceAnimation = BEEAnimations.growIn()
        attributes.exitAnimation = BEEAnimations.growOut()

        let contentView = UIView()
        contentView.clipsToBounds = true
        contentView.set(.width, of: 300)
        contentView.set(.height, of: 300)

        popup.display(entry: contentView, using: attributes)
    }

    @objc func customTest2() {

        var attributes = BEEAttributes.centerFloat
        attributes.displayDuration = .infinity
        attributes.precedence = .enqueue(priority: .high)
        attributes.screenBackground = .color(color: BEEColor(UIColor.black.withAlphaComponent(0.4)))
        attributes.entryBackground = .color(color: .white)
        attributes.entryInteraction = .absorbTouches
        attributes.screenInteraction = .dismiss
        attributes.positionConstraints.maxSize = .init(width: .ratio(value: 1.0), height: .ratio(value: 0.9))
        attributes.roundCorners = .all(radius: 15)
        attributes.entranceAnimation = BEEAnimations.growIn()
        attributes.exitAnimation = BEEAnimations.growOut()

        let contentVC = TestViewController()
        contentVC.view.set(.width, of: 300)
        contentVC.view.set(.height, of: 300)

        popup.display(entry: contentVC, using: attributes)
    }

    @objc func customTest3() {

        var attributes = BEEAttributes.bottomToast
        attributes.displayDuration = .infinity
        attributes.precedence = .enqueue(priority: .high)
        attributes.screenBackground = .color(color: BEEColor(UIColor.black.withAlphaComponent(0.4)))
        attributes.entryBackground = .color(color: .white)
        attributes.entryInteraction = .absorbTouches
        attributes.screenInteraction = .dismiss
        attributes.positionConstraints.maxSize = .init(width: .ratio(value: 1.0), height: .ratio(value: 0.9))
        attributes.roundCorners = .top(radius: 15)
        attributes.positionConstraints.size = .init(width: .fill, height: .ratio(value: 0.6))
        attributes.positionConstraints.safeArea = .overridden

        let contentVC = TestViewController()
        let nav = UINavigationController(rootViewController: contentVC)

        popup.display(entry: nav, using: attributes)
    }
}


class TestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Test"
        self.view.backgroundColor = .yellow
        self.view.clipsToBounds = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(Test2ViewController(), animated: true)
    }
}

class Test2ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Test2"
        self.view.backgroundColor = .red
        self.view.clipsToBounds = true
    }
}
