//
//  UILabel+ComputeSize.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/13.
//

import UIKit

public extension UILabel {
    func bee_computeHeight(by size: CGSize) -> CGFloat {
        let statusLabelText: NSString = (text ?? "") as NSString
        let dic = NSDictionary(object: font!, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key: Any], context: nil).size
        return strSize.height + 2
    }
    func bee_computeWidth(by size: CGSize) -> CGFloat {
        let statusLabelText: NSString = (text ?? "") as NSString
        let dic = NSDictionary(object: font!, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key: Any], context: nil).size
        return strSize.width + 2
    }
}
