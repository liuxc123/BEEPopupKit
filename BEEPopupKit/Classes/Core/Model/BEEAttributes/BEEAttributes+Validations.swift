//
//  BEEAttributes+Validations.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import Foundation

extension BEEAttributes {

    private static var minDisplayDuration: DisplayDuration {
        return 0
    }

    var validateDisplayDuration: Bool {
        guard displayDuration >= BEEAttributes.minDisplayDuration else {
            return false
        }
        return true
    }

    var validateWindowLevel: Bool {
        return windowLevel.value >= .normal
    }

    var isValid: Bool {
        return validateDisplayDuration && validateWindowLevel
    }
}

