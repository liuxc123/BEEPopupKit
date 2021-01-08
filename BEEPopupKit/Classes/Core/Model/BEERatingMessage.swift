//
//  BEERatingMessage.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/8.
//

import Foundation

public struct BEERatingMessage {

    // NOTE: Intentionally a reference type
    class SelectedIndex {
        var selectedIndex: Int!
    }

    /** Selection */
    public typealias Selection = (Int) -> Void

    /** Initial title */
    public var initialTitle: BEEProperty.LabelContent

    /** Initial description */
    public var initialDescription: BEEProperty.LabelContent

    /** Rating items */
    public var ratingItems: [BEEProperty.BEERatingItemContent]

    /** Button bar content appears after selection */
    public var buttonBarContent: BEEProperty.ButtonBarContent

    /** Selection event - Each time the user interacts a rating star */
    public var selection: Selection!

    let selectedIndexRef = SelectedIndex()

    /** Selected index (if there is one) */
    public var selectedIndex: Int? {
        get {
            return selectedIndexRef.selectedIndex
        }
        set {
            selectedIndexRef.selectedIndex = newValue
        }
    }

    /** Initializer */
    public init(initialTitle: BEEProperty.LabelContent,
                initialDescription: BEEProperty.LabelContent,
                ratingItems: [BEEProperty.BEERatingItemContent],
                buttonBarContent: BEEProperty.ButtonBarContent,
                selection: Selection? = nil) {
        self.initialTitle = initialTitle
        self.initialDescription = initialDescription
        self.ratingItems = ratingItems
        self.buttonBarContent = buttonBarContent
        self.selection = selection
    }
}

