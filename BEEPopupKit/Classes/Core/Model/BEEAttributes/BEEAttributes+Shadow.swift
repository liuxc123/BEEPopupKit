//
//  BEEAttributes+Shadow.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import Foundation
import UIKit

public extension BEEAttributes {

    /** The shadow around the entry */
    enum Shadow {

        /** No shadow */
        case none

        /** Shadow with value */
        case active(with: Value)

        /** The shadow properties */
        public struct Value {
            public let radius: CGFloat
            public let opacity: Float
            public let color: BEEColor
            public let offset: CGSize

            public init(color: BEEColor = .black,
                        opacity: Float,
                        radius: CGFloat,
                        offset: CGSize = .zero) {
                self.color = color
                self.radius = radius
                self.offset = offset
                self.opacity = opacity
            }
        }
    }
}



