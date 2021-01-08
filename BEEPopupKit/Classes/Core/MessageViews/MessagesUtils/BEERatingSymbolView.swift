//
//  BEERatingSymbolView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

final public class BEERatingSymbolView: UIView {

    private let button = UIButton()
    private let imageView = UIImageView()

    private let unselectedImage: BEEProperty.ImageContent
    private let selectedImage: BEEProperty.ImageContent

    var selection: BEERatingMessage.Selection

    public var isSelected: Bool {
        set {
            imageView.imageContent = newValue ? selectedImage : unselectedImage
        }
        get {
            return imageView.image == selectedImage.images.first
        }
    }

    public init(unselectedImage: BEEProperty.ImageContent, selectedImage: BEEProperty.ImageContent, selection: @escaping BEERatingMessage.Selection) {
        self.unselectedImage = unselectedImage
        self.selectedImage = selectedImage
        self.selection = selection
        super.init(frame: .zero)
        setupImageView()
        setupButton()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton() {
        addSubview(button)
        button.fillSuperview()
        button.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchDown), for: [.touchDown])
        button.addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }

    private func setupImageView() {
        addSubview(imageView)
        imageView.imageContent = unselectedImage
        imageView.centerInSuperview()
        imageView.sizeToSuperview(withRatio: 0.7)
    }

    @objc func touchUpInside() {
        selection(tag)
    }

    @objc func touchDown() {
        transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
    }

    @objc func touchUp() {
        transform = CGAffineTransform(scaleX: 1, y: 1)
    }
}

