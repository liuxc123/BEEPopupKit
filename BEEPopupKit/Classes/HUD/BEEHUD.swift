//
//  Hud.swift
//  HHProgressHUD
//
//  Created by ios on 2019/11/30.
//

import UIKit

public enum HUDType {
    case success
    case error
    case info
    var image: String {
        switch self {
        case .success:
            return "success"
        case .error:
            return "error"
        case .info:
            return "info"
        }
    }
}

public class BEEHUD {
    
    private init() {}
    
    public static func success(_ message: String,
                        duration: TimeInterval? = nil,
                        view: UIView? = nil) {
        guard let image = UIImage(named: "success") else { return }
        show(image: image, text: message, detail: nil, duration: duration, view: view)
    }
    
    public static func error(_ message: String,
                      duration: TimeInterval? = nil,
                      view: UIView? = nil) {
        guard let image = UIImage(named: "error") else { return }
        show(image: image, text: message, detail: nil, duration: duration, view: view)
    }
    
    static func info(_ message: String,
                     duration: TimeInterval? = nil,
                     view: UIView? = nil) {
        guard let image = UIImage(named: "info") else { return }
        show(image: image, text: message, detail: nil, duration: duration, view: view)
    }
    
    public static func show(image: UIImage,
                     text: String? = nil,
                     detail: String? = nil,
                     duration: TimeInterval? = nil,
                     view: UIView? = nil) {
        let config = BEEHUDConfig.shared
        var attributes = BEEAttributes.bee_hud
        attributes.displayDuration = duration == nil ? config.defaultDuration : duration!
        attributes.displayMode = config.displayMode
        attributes.displayDuration = duration ?? config.defaultDuration
        attributes.positionConstraints.verticalOffset = config.verticalOffset
        attributes.positionConstraints.size = .init(width: .constant(value: 100), height: .constant(value: 100))
        
        let imageContent = BEEProperty.ImageContent(image: image, size: CGSize(width: 35, height: 35))
        
        let titleContent = BEEProperty.LabelContent(text: text ?? "",
                                                   style: .init(font: config.textFont,
                                                                color: BEEColor(config.textColor),
                                                                alignment: config.textAlightment,
                                                                displayMode: config.displayMode,
                                                                numberOfLines: config.textNumberOfLines))
        
        let contentView = BEEHUDMessageView(with: BEEHUDMessage(image: imageContent, title: titleContent))
        
        if let view = view {
            BEEPopupKit.display(entry: contentView, using: attributes, presentView: view)
        } else {
            BEEPopupKit.display(entry: contentView, using: attributes)
        }
    }
    
    public static func dismiss(view: UIView? = nil) {
        if let view = view {
            BEEPopupKit.dismiss(form: view)
        } else {
            BEEPopupKit.dismiss()
        }
    }
}

