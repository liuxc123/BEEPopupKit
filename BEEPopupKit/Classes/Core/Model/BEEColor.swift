//
//  BEEColor.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

/** A color representation attribute as per user interface style */
public struct BEEColor: Equatable {

    // MARK: - Properties

    public private(set) var dark: UIColor
    public private(set) var light: UIColor

    // MARK: - Setup

    public init(light: UIColor, dark: UIColor) {
        self.light = light
        self.dark = dark
    }

    public init(_ unified: UIColor) {
        self.light = unified
        self.dark = unified
    }

    public init(rgb: Int) {
        dark = UIColor(rgb: rgb)
        light = UIColor(rgb: rgb)
    }

    public init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        let color = UIColor(red: CGFloat(red) / 255.0,
                            green: CGFloat(green) / 255.0,
                            blue: CGFloat(blue) / 255.0,
                            alpha: 1.0)
        light = color
        dark = color
    }

    /** Computes the proper UIColor */
    public func color(for traits: UITraitCollection,
                      mode: BEEAttributes.DisplayMode) -> UIColor {
        switch mode {
        case .inferred:
            if #available(iOS 13, *) {
                switch traits.userInterfaceStyle {
                case .light, .unspecified:
                    return light
                case .dark:
                    return dark
                @unknown default:
                    return light
                }
            } else {
                return light
            }
        case .light:
            return light
        case .dark:
            return dark
        }
    }
}

public extension BEEColor {

    /// Returns the inverse of `self` (light and dark swapped)
    var inverted: BEEColor {
        return BEEColor(light: dark, dark: light)
    }

    /** Returns an `BEEColor` with the specified alpha component */
    func with(alpha: CGFloat) -> BEEColor {
        return BEEColor(light: light.withAlphaComponent(alpha),
                       dark: dark.withAlphaComponent(alpha))
    }

    /** White color for all user interface styles */
    static var white: BEEColor {
        return BEEColor(.white)
    }

    /** Black color for all user interface styles */
    static var black: BEEColor {
        return BEEColor(.black)
    }

    /** Clear color for all user interface styles */
    static var clear: BEEColor {
        return BEEColor(.clear)
    }

    /** Color that represents standard background. White for light mode, black for dark mode */
    static var standardBackground: BEEColor {
        return BEEColor(light: .white, dark: .black)
    }

    /** Color that represents standard content. black for light mode, white for dark mode */
    static var standardContent: BEEColor {
        return BEEColor(light: .black, dark: .white)
    }
}

