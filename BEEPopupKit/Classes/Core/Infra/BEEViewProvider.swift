//
//  BEEViewProvider.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

final class BEEViewProvider: EntryPresenterDelegate {

    /** Current entry presentView */
    private weak var presentView: UIView!

    /** Current entry view */
    private var entryView: BEEEntryView!

    /** Current root controller */
    private var entryVC: BEERootViewController?

    /** Cannot be instantiated, customized, inherited */
    fileprivate init(presentView: UIView) {
        self.presentView = presentView
    }

    var isResponsiveToTouches: Bool = false

    // MARK: - Setup and Teardown methods

    // Prepare the view and the host view controller
    private func prepare(for attributes: BEEAttributes, presentView: UIView) -> BEERootViewController? {
        if entryVC == nil {
            entryVC = BEERootViewController(with: self)
        }
        entryVC!.setStatusBarStyle(for: attributes)
        presentView.addSubview(entryVC!.view)
        entryVC?.view.fillSuperview()

        return entryVC
    }

    /** Display a view using attributes */
    static func display(view: UIView, using attributes: BEEAttributes, presentView: UIView) {
        let entryView = BEEEntryView(newEntry: .init(view: view, attributes: attributes))
        presentView.popupProvider?.show(entryView: entryView, presentView: presentView)
    }

    /** Display a view using attributes */
    static func display(viewController: UIViewController, using attributes: BEEAttributes, presentView: UIView) {
        let entryView = BEEEntryView(newEntry: .init(viewController: viewController, attributes: attributes))
        presentView.popupProvider?.show(entryView: entryView, presentView: presentView)
    }

    func displayPendingEntryOrRollbackWindow(dismissCompletionHandler: BEEPopupKit.DismissCompletionHandler?) {

        // Execute dismiss handler
        dismissCompletionHandler?()

        // clear current entry view
        entryVC?.view.removeFromSuperview()
        entryVC = nil
        entryView = nil
    }

    /** Dismiss a view using attributes */
    static func dismiss(presentView: UIView, with completion: BEEPopupKit.DismissCompletionHandler? = nil) {
        guard let entryVC = presentView.popupProvider?.entryVC else {
            return
        }
        entryVC.animateOutLastEntry(completionHandler: completion)
    }

    /** Layout the view-hierarchy rooted in the window */
    func layoutIfNeeded() {
        presentView?.layoutIfNeeded()
    }

    /** Privately used to prepare the root view controller and show the entry immediately */
    private func show(entryView: BEEEntryView, presentView: UIView) {
        guard let entryVC = prepare(for: entryView.attributes, presentView: presentView) else {
            return
        }
        entryVC.configure(entryView: entryView)
        self.entryVC = entryVC
        self.entryView = entryView
    }

}

fileprivate var popup_provider_key = "popup_provider_key"

extension UIView {

    fileprivate var popupProvider: BEEViewProvider? {
        set {
            objc_setAssociatedObject(self, &popup_provider_key, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            guard let provider = objc_getAssociatedObject(self, &popup_provider_key) as? BEEViewProvider else {
                let provider = BEEViewProvider(presentView: self)
                objc_setAssociatedObject(self, &popup_provider_key, provider, .OBJC_ASSOCIATION_RETAIN)
                return provider
            }
            return provider
        }
    }
}
