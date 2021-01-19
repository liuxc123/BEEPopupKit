//
//  ViewController+Sheet.swift
//  BEEPopupKit_Example
//
//  Created by liuxc on 2021/1/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BEEPopupKit

extension ViewController {

    func globalActionSheetSetting() {
        // Global Setting
        BEEActionSheetViewConfig.shared.titleColor = BEEColor(.systemGray)
        BEEActionSheetViewConfig.shared.messageColor = BEEColor(.systemGray)
        BEEActionSheetViewConfig.shared.actionNormalColor = BEEColor(.systemBlue)
        BEEActionSheetViewConfig.shared.actionCancelColor = BEEColor(.systemBlue)
        BEEActionSheetViewConfig.shared.actionDestructiveColor = BEEColor(.systemRed)
        BEEActionSheetViewConfig.shared.actionDisableColor = BEEColor(.systemGray)
        BEEActionSheetViewConfig.shared.actionPressedColor = BEEColor(.systemBackground)
        BEEActionSheetViewConfig.shared.backgroundColor = BEEColor(.systemBackground)
    }

    // 示例1:actionSheet的默认动画样式(从底部弹出，有取消按钮)
    @objc func actionSheetTest1 () {
        let actionSheet = BEEActionSheetView(title: "我是主标题", message: "我是副标题", imageName: "zhiwen")

        let action1 = BEEAlertAction(title: "Default", style: .default) { (action) in
            print("点击了Default")
        }

        let action2 = BEEAlertAction(title: "Destructive", style: .destructive) { (action) in
            print("点击了Default")
        }

        let action3 = BEEAlertAction(title: "Disabled", style: .default) { (action) in
            print("点击了Disabled")
        }
        action3.disabled = true

        let action4 = BEEAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("点击了Cancel")
        }

        actionSheet.addAction(action1)
        actionSheet.addAction(action3) // 取消按钮一定排在最底部
        actionSheet.addAction(action2)
        actionSheet.addAction(action4)
        actionSheet.show()
    }

    // 示例2:actionSheet的默认动画(从底部弹出,无取消按钮)
    @objc func actionSheetTest2 () {
        let actionSheet = BEEActionSheetView(title: "我是主标题", message: "我是副标题", imageName: "zhiwen")

        let action1 = BEEAlertAction(title: "Default", style: .default) { (action) in
            print("点击了Default")
        }

        let action2 = BEEAlertAction(title: "Destructive", style: .destructive) { (action) in
            print("点击了Default")
        }

        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.show()
    }

    // 示例3:actionSheet 模拟多分区样式
    @objc func actionSheetTest3 () {
        let actionSheet = BEEActionSheetView(title: "我是主标题", message: "我是副标题", imageName: "zhiwen")

        let action1 = BEEAlertAction(title: "第1个", style: .default) { (action) in
            print("点击了第1个")
        }
        action1.titleColor = BEEColor(.orange)

        let action2 = BEEAlertAction(title: "第2个", style: .destructive) { (action) in
            print("点击了第2个")
        }
        action2.titleColor = BEEColor(.orange)

        let action3 = BEEAlertAction(title: "第3个", style: .default) { (action) in
            print("点击了第3个")
        }
        let action4 = BEEAlertAction(title: "第4个", style: .default) { (action) in
            print("点击了第4个")
        }
        let action5 = BEEAlertAction(title: "第5个", style: .default) { (action) in
            print("点击了第5个")
        }
        let action6 = BEEAlertAction(title: "第6个", style: .default) { (action) in
            print("点击了第6个")
        }
        let action7 = BEEAlertAction(title: "第7个", style: .cancel) { (action) in
            print("点击了第7个")
        }

        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        actionSheet.addAction(action4)
        actionSheet.addAction(action5)
        actionSheet.addAction(action6)
        actionSheet.addAction(action7)
        actionSheet.show()
    }

    // 示例4:actionSheet 极限情况
    @objc func actionSheetTest4() {

        let alert = BEEActionSheetView(title: "title", message: "message\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage", imageName: "zhiwen")

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
        alert.addAction(action)

        alert.addAction(BEEAlertAction(title: "确定", style: .default, handler: { (action) in
            print(action.title)
        }))

        alert.addAction(BEEAlertAction(title: "确定", style: .default, handler: { (action) in
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
