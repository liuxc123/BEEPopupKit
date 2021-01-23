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

    let dataSource: [(String, [(String, Selector)])] = [
        ("Action Sheet", [
            ("actionSheet的默认动画样式(从底部弹出，有取消按钮)", #selector(actionSheetTest1)),
            ("actionSheet的默认动画(从底部弹出,无取消按钮)", #selector(actionSheetTest2)),
            ("actionSheet 模拟多分区样式", #selector(actionSheetTest3)),
            ("actionSheet 极限情况", #selector(actionSheetTest4))
        ]),
        ("Alert", [
            ("alert 默认弹框", #selector(alertTest1)),
            ("alert 极限情况", #selector(alertTest2)),
            ("alert 带输入框", #selector(alertTest3)),
            ("alertController 默认情况", #selector(alertTest4))
        ]),
        ("Popup", [
            ("自定义Popup", #selector(customTest1))
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        globalAlertSetting()
        globalActionSheetSetting()

        var sections = [TableSection]()

        for sectionModel in dataSource {
            let section = TableSection(headerTitle: sectionModel.0, footerTitle: nil)
            section.headerHeight = 50
            section.footerHeight = 0

            for rowModel in sectionModel.1 {
                let row = TableRow<DemoListCell>(value: rowModel.0)
                    .on(.click) { [weak self] (options) in
                        self?.perform(rowModel.1)
                    }
                section.append(row: row)
            }

            sections.append(section)
        }
        
        tableDirector.append(sections: sections)
    }

}

