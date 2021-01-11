//
//  BEEPopupKit+Bundle.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/11.
//

import Foundation

extension BEEPopupKit {

    public static var bundle: Bundle? {
        let temBundle = Bundle(for: BEEPopupKit.self)
        if let url = temBundle.url(forResource: "BEEPopupKit", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return bundle ?? temBundle
        }
        return temBundle
    }
}
