//
//  ViewController.swift
//  BEEPopupKit
//
//  Created by liuxc123 on 01/08/2021.
//  Copyright (c) 2021 liuxc123. All rights reserved.
//

import UIKit
import BEEPopupKit
import BEETableKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    lazy var tableDirector: TableDirector = {
        return TableDirector(tableView: tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let section1 = TableSection(headerTitle: "自定义视图", footerTitle: nil)
        section1.headerHeight = 50
        section1.footerHeight = 0
        
        let row1 = TableRow<DemoListCell>(value: "custom view")
            .on(.click) { [weak self] (options) in
                self?.showCustomView()
            }
        section1.append(row: row1)
        
        let row2 = TableRow<DemoListCell>(value: "alert view")
            .on(.click) { [weak self] (options) in
                self?.showAlertView()
            }
        section1.append(row: row2)
        
        let row3 = TableRow<DemoListCell>(value: "action sheet view")
            .on(.click) { [weak self] (options) in
                self?.showActionSheetView()
            }
        section1.append(row: row3)
        
        tableDirector.append(section: section1)
    }

    func showAlertView() {

        // Global Setting
//        BEEAlertViewConfig.shared.titleColor = BEEColor(.lightText)
//        BEEAlertViewConfig.shared.messageColor = BEEColor(.lightText)
//        BEEAlertViewConfig.shared.actionNormalColor = BEEColor(.systemBlue)
//        BEEAlertViewConfig.shared.actionCancelColor = BEEColor(.systemBlue)
//        BEEAlertViewConfig.shared.actionDestructiveColor = BEEColor(.systemRed)
//        BEEAlertViewConfig.shared.actionDisableColor = BEEColor(.systemGray)
//        BEEAlertViewConfig.shared.actionPressedColor = BEEColor(.systemBackground)
//        BEEAlertViewConfig.shared.backgroundColor = BEEColor(.systemBackground)


        let alert = BEEAlertView(title: "title", message: "message\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage", imageName: "info")

//        let customView = UIView()
//        customView.backgroundColor = .yellow
//        customView.set(.height, of: 100)
//        alert.customView = customView

        for _ in 0 ... 20 {
            alert.addAction(action: BEEAlertAction(title: "确定", style: .default, handler: { (action) in
                print(action.title)
            }))
        }

        alert.addAction(action: BEEAlertAction(title: "确定", style: .default, handler: { (action) in
            print(action.title)
        }))
        alert.addAction(action: BEEAlertAction(title: "确定", style: .default, handler: { (action) in
            print(action.title)
        }))

        alert.show()
    }

    func showActionSheetView() {

        // Global Setting
//        BEEActionSheetViewConfig.shared.titleColor = BEEColor(.lightText)
//        BEEActionSheetViewConfig.shared.messageColor = BEEColor(.lightText)
//        BEEActionSheetViewConfig.shared.actionNormalColor = BEEColor(.systemBlue)
//        BEEActionSheetViewConfig.shared.actionCancelColor = BEEColor(.systemBlue)
//        BEEActionSheetViewConfig.shared.actionDestructiveColor = BEEColor(.systemRed)
//        BEEActionSheetViewConfig.shared.actionDisableColor = BEEColor(.systemGray)
//        BEEActionSheetViewConfig.shared.actionPressedColor = BEEColor(.systemBackground)
//        BEEActionSheetViewConfig.shared.backgroundColor = BEEColor(.systemBackground)




        let alert = BEEActionSheetView(title: "title", message: "message\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage", imageName: "zhiwen")

        //        let button = UIButton()
        //        button.backgroundColor = .yellow
        //        button.set(.height, of: 100)
        //        button.setTitle("自定义按钮", for: .default)
        //        button.addTarget(self, action: #selector(clickAction(_:)), for: .touchUpInside)
        //        alert.customView = button

//        let attributedTitle = NSMutableAttributedString(string: "确定")
//        attributedTitle.setAttributes(
//            [NSAttributedString.Key.foregroundColor : UIColor.blue],
//            range: NSRange(location: 0, length: 2)
//        )
//        alert.attributedTitle = attributedTitle
        
        let action = BEEAlertAction(title: "确定", style: .default, handler: { (action) in
            print(action.title)
        })
        alert.addAction(action: action)

        alert.addAction(action: BEEAlertAction(title: "确定", style: .default, handler: { (action) in
            print(action.title)
        }))

        alert.addAction(action: BEEAlertAction(title: "确定", style: .default, handler: { (action) in
            print(action.title)
        }))

        for _ in 0 ... 15 {
            alert.addAction(action: BEEAlertAction(title: "确定", style: .default, handler: { (action) in
                print(action.title)
            }))
        }

        alert.addAction(action: BEEAlertAction(title: "取消", style: .cancel, handler: { (action) in
            print(action.title)
        }))


        alert.show()
    }


    func showCustomView() {


        let alertController = UIAlertController(title: "title", message: "message\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage\nmessage", preferredStyle: .actionSheet)


        for _ in 0 ... 8 {
            alertController.addAction(UIAlertAction(title: "sure", style: .default, handler: { (action) in

            }))
        }

        alertController.addAction(UIAlertAction(title: "sure", style: .default, handler: { (action) in

        }))

        alertController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (action) in

        }))

        self.present(alertController, animated: true, completion: nil)
        
//        var attributes = BEEAttributes.centerFloat
//        attributes.displayDuration = .infinity
//        attributes.precedence = .enqueue(priority: .high)
//        attributes.screenBackground = .color(color: BEEColor(UIColor.black.withAlphaComponent(0.4)))
//        attributes.entryInteraction = .absorbTouches
//        attributes.positionConstraints.verticalOffset = 44
//        attributes.positionConstraints.size = .intrinsic
//        attributes.positionConstraints.maxSize = .init(width: .ratio(value: 1.0), height: .ratio(value: 0.9))
//        attributes.roundCorners = .all(radius: 10)
//        attributes.entranceAnimation = .init(translate: .init(duration: 0.3, anchorPosition: .top, delay: 0, spring: nil))
//
//        BEEPopupKit.display(entry: alertController, using: attributes)


//        let contentView = UIView()
//        contentView.backgroundColor = .reds
    }

    @objc func clickAction(_ sender: UIButton) {
        print(sender.title(for: .normal) ?? "")
    }
}

