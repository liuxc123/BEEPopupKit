//
//  BEEViewProvider.swift
//  BEEPopupView
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

final class BEEViewProvider: NSObject, EntryPresenterDelegate {

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
        let popupProvider = BEEViewProvider(presentView: presentView)
        presentView.popupProviders.append(popupProvider)
        popupProvider.display(entryView: entryView, using: attributes, presentView: presentView)
    }

    /** Display a view using attributes */
    static func display(viewController: UIViewController, using attributes: BEEAttributes, presentView: UIView) {
        let entryView = BEEEntryView(newEntry: .init(viewController: viewController, attributes: attributes))
        let popupProvider = BEEViewProvider(presentView: presentView)
        presentView.popupProviders.append(popupProvider)
        popupProvider.display(entryView: entryView, using: attributes, presentView: presentView)
    }
    
    func displayPendingEntryOrRollbackWindow(dismissCompletionHandler: BEEPopupKit.DismissCompletionHandler?) {

        // Display the rollback window
        removeFromPresentView()

        // As a last step, invoke the dismissal method
        dismissCompletionHandler?()
    }

    /** Dismiss a view using attributes */
    static func dismiss(presentView: UIView, contentViewController: UIViewController, with completion: BEEPopupKit.DismissCompletionHandler? = nil) {
        guard let provider = BEEViewProvider.popupProvider(presentView: presentView, contentView: nil, contentViewController: contentViewController) else {
            return
        }
        provider.entryVC?.animateOutLastEntry(completionHandler: completion)
    }

    static func dismiss(presentView: UIView, contentView: UIView, with completion: BEEPopupKit.DismissCompletionHandler? = nil) {
        guard let provider = BEEViewProvider.popupProvider(presentView: presentView, contentView: contentView, contentViewController: nil) else {
            return
        }
        provider.entryVC?.animateOutLastEntry(completionHandler: completion)
    }

    /** Layout the view-hierarchy rooted in the window */
    func layoutIfNeeded() {
        presentView?.layoutIfNeeded()
    }

    // clear current entry view
    private func removeFromPresentView() {
        entryVC?.view.removeFromSuperview()
        entryVC = nil
        entryView = nil
        presentView.popupProviders.removeAll { [weak self] (provider) -> Bool in
            guard let self = self else { return false }
            return provider == self
        }
    }
    
    /**
     Privately used to display an entry
     */
    private func display(entryView: BEEEntryView, using attributes: BEEAttributes, presentView: UIView) {
        show(entryView: entryView, presentView: presentView)
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

    private static func popupProvider(presentView: UIView, contentView: UIView?, contentViewController: UIViewController?) -> BEEViewProvider? {
        var provider: BEEViewProvider?
        for tempProvider in presentView.popupProviders {
            if tempProvider.entryView.content.view == contentView {
                provider = tempProvider
            }
            if tempProvider.entryView.content.viewController == contentViewController {
                provider = tempProvider
            }
        }
        return provider
    }
}

fileprivate var popup_provider_key = "popup_provider_key"

extension UIView {

    fileprivate var popupProviders: [BEEViewProvider] {
        set {
            objc_setAssociatedObject(self, &popup_provider_key, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            guard let provider = objc_getAssociatedObject(self, &popup_provider_key) as? [BEEViewProvider] else {
                objc_setAssociatedObject(self, &popup_provider_key, [], .OBJC_ASSOCIATION_RETAIN)
                return []
            }
            return provider
        }
    }
}
