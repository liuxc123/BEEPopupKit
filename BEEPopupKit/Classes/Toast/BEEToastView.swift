//
//  ToastView.swift
//  HHProgressHUD_Example
//
//  Created by ios on 2019/11/29.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

public class BEEToastMessageView: UIView {
    
    // MARK: Props
    
    private var label: UILabel!
    private let message: BEEProperty.LabelContent
    
    // MARK: Setup
    
    init(with message: BEEProperty.LabelContent) {
        self.message = message
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupLabel(content: message)
        setupLayout(message: message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel(content: BEEProperty.LabelContent) {
        label = UILabel()
        label.content = content
        addSubview(label)
    }
    
    private func setupLayout(message: BEEProperty.LabelContent) {
        label.layoutToSuperview(.top, offset: 10)
        label.layoutToSuperview(.bottom, offset: -10)
        label.layoutToSuperview(.left, offset: 10)
        label.layoutToSuperview(.right, offset: -10)
    }
}

