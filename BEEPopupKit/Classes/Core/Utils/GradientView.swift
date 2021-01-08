//
//  GradientView.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

class GradientView: UIView {

    struct Style {
        let gradient: BEEAttributes.BackgroundStyle.Gradient
        let displayMode: BEEAttributes.DisplayMode

        init?(gradient: BEEAttributes.BackgroundStyle.Gradient?,
              displayMode: BEEAttributes.DisplayMode) {
            guard let gradient = gradient else {
                return nil
            }
            self.gradient = gradient
            self.displayMode = displayMode
        }
    }

    private let gradientLayer = CAGradientLayer()

    var style: Style? {
        didSet {
            setupColor()
        }
    }

    init() {
        super.init(frame: .zero)
        layer.addSublayer(gradientLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private func setupColor() {
        guard let style = style else {
            return
        }
        gradientLayer.colors = style.gradient.colors.map {
            $0.color(for: traitCollection, mode: style.displayMode).cgColor
        }
        gradientLayer.startPoint = style.gradient.startPoint
        gradientLayer.endPoint = style.gradient.endPoint
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupColor()
    }
}

