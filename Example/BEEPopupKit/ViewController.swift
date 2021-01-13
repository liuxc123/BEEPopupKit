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
        BEEAlertViewConfig.shared.actionNormalColor = .red
        BEEAlertViewConfig.shared.cornerRadius = 20

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
        
        var attributes = BEEAttributes.centerFloat
        attributes.displayDuration = .infinity
        attributes.precedence = .enqueue(priority: .high)
        attributes.entryInteraction = .absorbTouches
        attributes.positionConstraints.verticalOffset = 44
        attributes.positionConstraints.size = .init(width: .constant(value: 300), height: .constant(value: 300))
        attributes.roundCorners = .all(radius: 10)
        attributes.position = .bottomLeft
        attributes.entranceAnimation = .init(translate: .init(duration: 0.3, anchorPosition: .top, delay: 0, spring: nil))
        
        BEEPopupKit.display(entry: contentView, using: attributes, presentView: view)
                
    }
}

