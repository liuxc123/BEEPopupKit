//
//  ViewController+Alert.swift
//  BEEPopupKit_Example
//
//  Created by liuxc on 2021/1/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BEEPopupKit

extension ViewController {

    func globalAlertSetting() {
        // Global Setting
        BEEAlertViewConfig.shared.titleColor = BEEColor(.systemGray)
        BEEAlertViewConfig.shared.messageColor = BEEColor(.systemGray)
        BEEAlertViewConfig.shared.actionNormalColor = BEEColor(.systemBlue)
        BEEAlertViewConfig.shared.actionCancelColor = BEEColor(.systemBlue)
        BEEAlertViewConfig.shared.actionDestructiveColor = BEEColor(.systemRed)
        BEEAlertViewConfig.shared.actionDisableColor = BEEColor(.systemGray)
        BEEAlertViewConfig.shared.actionPressedColor = BEEColor(.systemBackground)
        BEEAlertViewConfig.shared.backgroundColor = BEEColor(.systemBackground)
    }

    // 示例1:alert 默认弹框
    @objc func alertTest1() {

        let alert = BEEAlertView(title: "我是主标题", message: "我是副标题", imageName: "info")

        let action1 = BEEAlertAction(title: "确定", style: .default) { (action) in
            print("点击了确定")
        }
        // 设置第1个action的颜色
        action1.titleColor = BEEColor(.orange)
        let action2 = BEEAlertAction(title: "取消", style: .destructive) { (action) in
            print("点击了取消")
        }
        action2.titleColor = BEEColor(.red)
        alert.addAction(action1)
        alert.addAction(action2)
        alert.show()
    }

    // 示例2:alert 极限情况
    @objc func alertTest2() {

        let alert = BEEAlertView(title: "我是主标题", message: "message\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage", imageName: "zhiwen")

        let button = UIButton()
        button.backgroundColor = .yellow
        button.set(.height, of: 100)
        button.setTitle("自定义按钮", for: .normal)
        alert.customHeaderView = button

        let customView = UIView()
        customView.backgroundColor = .yellow
        customView.set(.height, of: 100)
        alert.customActionSequenceView = customView

        let action = BEEAlertAction(title: "确定", style: .default, handler: { (action) in
            print(action.title)
        })
        action.disabled = true
        alert.addAction(action)

        alert.addAction(BEEAlertAction(title: "确定", style: .default, canAutoHide: false, handler: { (action) in
            print(action.title)
        }))

        for _ in 0 ... 15 {
            alert.addAction(BEEAlertAction(title: "确定", style: .default, handler: { (action) in
                print(action.title)
            }))
        }

        alert.addAction(BEEAlertAction(title: "取消", style: .cancel, handler: { (action) in
            print(action.title)
        }))

        alert.show()
    }

}
