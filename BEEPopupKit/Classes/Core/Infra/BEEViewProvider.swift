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
    
    /** Entry queueing heuristic  */
    private let entryQueue = BEEAttributes.Precedence.QueueingHeuristic.value.heuristic

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
    
    // MARK: - Exposed Actions

    func queueContains(entryNamed name: String? = nil) -> Bool {
        if name == nil && !entryQueue.isEmpty {
            return true
        }
        if let name = name {
            return entryQueue.contains(entryNamed: name)
        } else {
            return false
        }
    }

    /**
     Returns *true* if the currently displayed entry has the given name.
     In case *name* has the value of *nil*, the result is *true* if any entry is currently displayed.
     */
    func isCurrentlyDisplaying(entryNamed name: String? = nil) -> Bool {
        guard let entryView = entryView else {
            return false
        }
        if let name = name { // Test for names equality
            return entryView.content.attributes.name == name
        } else { // Return true by default if the name is *nil*
            return true
        }
    }

    /** Transform current entry to view */
    static func transform(to view: UIView, presentView: UIView) {
        presentView.popupProvider?.entryView?.transform(to: view)
    }

    /** Display a view using attributes */
    static func display(view: UIView, using attributes: BEEAttributes, presentView: UIView) {
        let entryView = BEEEntryView(newEntry: .init(view: view, attributes: attributes))
        presentView.popupProvider?.display(entryView: entryView, using: attributes, presentView: presentView)
    }

    /** Display a view using attributes */
    static func display(viewController: UIViewController, using attributes: BEEAttributes, presentView: UIView) {
        let entryView = BEEEntryView(newEntry: .init(viewController: viewController, attributes: attributes))
        presentView.popupProvider?.display(entryView: entryView, using: attributes, presentView: presentView)
    }
    
    
    func displayPendingEntryOrRollbackWindow(dismissCompletionHandler: BEEPopupKit.DismissCompletionHandler?) {
        
        if let next = entryQueue.dequeue() {

            // Execute dismiss handler if needed before dequeuing (potentially) another entry
            dismissCompletionHandler?()

            // Show the next entry in queue
            show(entryView: next.view, presentView: presentView)
        } else {

            // Display the rollback window
            removeFromPresentView()

            // As a last step, invoke the dismissal method
            dismissCompletionHandler?()
        }
    }

    /** Dismiss a view using attributes */
    static func dismiss(presentView: UIView, with completion: BEEPopupKit.DismissCompletionHandler? = nil) {
        guard let entryVC = presentView.popupProvider?.entryVC else {
            return
        }
        entryVC.animateOutLastEntry(completionHandler: completion)
    }
    
    // clear current entry view
    func removeFromPresentView() {
        entryVC?.view.removeFromSuperview()
        entryVC = nil
        entryView = nil
    }

    /** Layout the view-hierarchy rooted in the window */
    func layoutIfNeeded() {
        presentView?.layoutIfNeeded()
    }
    
    /**
     Privately used to display an entry
     */
    private func display(entryView: BEEEntryView, using attributes: BEEAttributes, presentView: UIView) {
        switch entryView.attributes.precedence {
        case .override(priority: _, dropEnqueuedEntries: let dropEnqueuedEntries):
            if dropEnqueuedEntries {
                entryQueue.removeAll()
            }
            show(entryView: entryView, presentView: presentView)
        case .enqueue where isCurrentlyDisplaying():
            entryQueue.enqueue(entry: .init(view: entryView, presentView: presentView))
        case .enqueue:
            show(entryView: entryView, presentView: presentView)
        }
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
