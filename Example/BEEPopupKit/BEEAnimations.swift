//
//  BEEAnimations.swift
//  BEEPopupKit_Example
//
//  Created by liuxc on 2021/1/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BEEPopupKit

struct BEEAnimations {
    
    static func fadeIn() -> BEEAttributes.Animation {
        return .init(fade: .init(from: 0, to: 1, duration: 0.3))
    }
    
    static func growIn() -> BEEAttributes.Animation {
        return .init(scale: .init(from: 0.85, to: 1, duration: 0.3),
                     fade: .init(from: 0, to: 1, duration: 0.3))
    }
    
    static func shrinkIn() -> BEEAttributes.Animation {
        return .init(scale: .init(from: 1.3, to: 1, duration: 0.3),
                     fade: .init(from: 0, to: 1, duration: 0.3))
    }
    
    static func slide() -> BEEAttributes.Animation {
        return .init(translate: .init(duration: 0.3))
    }
    
    static func bounceIn() -> BEEAttributes.Animation {
        return .init(scale: .init(from: 0.85, to: 1, duration: 0.3, delay: 0, spring: .init(damping: 0.8, initialVelocity: 10)))
    }
    
    static func fadeOut() -> BEEAttributes.Animation {
        return .init(fade: .init(from: 1, to: 0, duration: 0.3))
    }
    
    static func growOut() -> BEEAttributes.Animation {
        return .init(scale: .init(from: 1, to: 1.1, duration: 0.3),
                     fade: .init(from: 1, to: 0, duration: 0.3))
    }
    
    static func shrinkOut() -> BEEAttributes.Animation {
        return .init(scale: .init(from: 1, to: 0.8, duration: 0.3))
    }
    
    static func bounceOut() -> BEEAttributes.Animation {
        return .init(scale: .init(from: 1, to: 0.85, duration: 0.3, delay: 0, spring: .init(damping: 0.8, initialVelocity: 10)))
    }
}
