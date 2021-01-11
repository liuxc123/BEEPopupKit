//
//  ViewController.swift
//  BEEPopupKit
//
//  Created by liuxc123 on 01/08/2021.
//  Copyright (c) 2021 liuxc123. All rights reserved.
//

import UIKit
import BEEPopupKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        BEEAlertViewConfig.shared.actionNormalColor = .red
        BEEAlertViewConfig.shared.cornerRadius = 20

    }

    @IBAction func clickAction(_ sender: Any) {
        showAlertView()
//        showActionSheetView()
//        showCustomView()
//        showToastView()
    }

    func showAlertView() {
        let alert = BEEAlertView(title: "title", message: "message")
        alert.addAction(action: BEEAlertAction(title: "确定", style: .normal, handler: { (action) in
            print(action.title)
        }))
        alert.addAction(action: BEEAlertAction(title: "确定", style: .normal, handler: { (action) in
            print(action.title)
        }))
        alert.addAction(action: BEEAlertAction(title: "确定", style: .normal, handler: { (action) in
            print(action.title)
        }))
        alert.addAction(action: BEEAlertAction(title: "确定", style: .normal, handler: { (action) in
            print(action.title)
        }))
        alert.addAction(action: BEEAlertAction(title: "确定", style: .normal, handler: { (action) in
            print(action.title)
        }))
        alert.addAction(action: BEEAlertAction(title: "取消", style: .cancel, handler: { (action) in
            print(action.title)
        }))
        alert.show()
    }

    func showActionSheetView() {
        let alert = BEEActionSheetView(title: "title", message: "message")
        alert.addAction(action: BEEAlertAction(title: "确定", style: .normal, handler: { (action) in
            print(action.title)
        }))
        alert.addAction(action: BEEAlertAction(title: "确定", style: .normal, handler: { (action) in
            print(action.title)
        }))
        alert.addAction(action: BEEAlertAction(title: "确定", style: .normal, handler: { (action) in
            print(action.title)
        }))
        alert.addAction(action: BEEAlertAction(title: "确定", style: .normal, handler: { (action) in
            print(action.title)
        }))
        alert.addAction(action: BEEAlertAction(title: "确定", style: .normal, handler: { (action) in
            print(action.title)
        }))
        alert.addAction(action: BEEAlertAction(title: "取消", style: .cancel, handler: { (action) in
            print(action.title)
        }))
        alert.show()
    }
    
    func showCustomView() {
        let contentView = UIView()
        contentView.backgroundColor = .red
        contentView.set(.width, of: 300)
        contentView.set(.height, of: 300)
        
        var attributes = BEEAttributes.topFloat
        attributes.displayDuration = .infinity
        attributes.precedence = .enqueue(priority: .high)
        attributes.entranceAnimation = BEEAnimations.bounceIn()
        attributes.exitAnimation = BEEAnimations.bounceOut()
        attributes.popBehavior = .overridden
        attributes.entryInteraction = .absorbTouches
        
        BEEPopupKit.display(entry: contentView, using: attributes, presentView: view)
    }
    
    func showToastView() {
        BEEToast.show("adsasdasdaaaadada\nasdad\na", view: view)
    }
}

