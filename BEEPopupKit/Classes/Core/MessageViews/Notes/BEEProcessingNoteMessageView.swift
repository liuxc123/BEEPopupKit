//
//  BEEProcessingNoteMessageView.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import UIKit

public class BEEProcessingNoteMessageView: BEEAccessoryNoteMessageView {

    // MARK: Props
    private var activityIndicatorView: UIActivityIndicatorView!
    private var noteMessageView: BEENoteMessageView!

    /** Activity indication can be turned off / on */
    public var isProcessing: Bool = true {
        didSet {
            if isProcessing {
                activityIndicatorView.startAnimating()
            } else {
                activityIndicatorView.stopAnimating()
            }
        }
    }

    // MARK: Setup
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(with content: BEEProperty.LabelContent, activityIndicator: UIActivityIndicatorView.Style) {
        super.init(frame: UIScreen.main.bounds)
        setup(with: content, activityIndicator: activityIndicator)
    }

    private func setup(with content: BEEProperty.LabelContent, activityIndicator: UIActivityIndicatorView.Style, setProcessing: Bool = true) {
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = activityIndicator
        isProcessing = setProcessing
        accessoryView = activityIndicatorView
        super.setup(with: content)
    }
}

