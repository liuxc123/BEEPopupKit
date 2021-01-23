//
//  BEEWindowProvider.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

final class BEEWindowProvider: EntryPresenterDelegate {

    /** The artificial safe area insets */
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return BEEWindowProvider.shared.entryWindow?.rootViewController?.view?.safeAreaInsets ?? UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets ?? .zero
        } else {
            let statusBarMaxY = UIApplication.shared.statusBarFrame.maxY
            return UIEdgeInsets(top: statusBarMaxY, left: 0, bottom: 10, right: 0)
        }
    }

    /** Single access point */
    static let shared = BEEWindowProvider()

    /** Current entry window */
    var entryWindow: BEEWindow!

    /** Returns the root view controller if it is instantiated */
    var rootVC: BEERootViewController? {
        return entryWindow?.rootViewController as? BEERootViewController
    }

    /** A window to go back to when the last entry has been dismissed */
    private var rollbackWindow: BEEPopupKit.RollbackWindow!

    /** The main rollback window to be used internally in case `rollbackWindow`'s value is `.main` */
    private weak var mainRollbackWindow: UIWindow?

    /** Entry queueing heuristic  */
    private let entryQueue = BEEAttributes.Precedence.QueueingHeuristic.value.heuristic

    private weak var entryView: BEEEntryView!

    /** Cannot be instantiated, customized, inherited */
    private init() {}

    var isResponsiveToTouches: Bool {
        set {
            entryWindow?.isAbleToReceiveTouches = newValue
        }
        get {
            return entryWindow?.isAbleToReceiveTouches ?? false
        }
    }

    // MARK: - Setup and Teardown methods

    // Prepare the window and the host view controller
    private func prepare(for attributes: BEEAttributes, presentInsideKeyWindow: Bool) -> BEERootViewController? {
        let entryVC = setupWindowAndRootVC()
        guard entryVC.canDisplay(attributes: attributes) || attributes.precedence.isEnqueue else {
            return nil
        }
        entryVC.setStatusBarStyle(for: attributes)

        entryWindow.windowLevel = attributes.windowLevel.value
        if presentInsideKeyWindow {
            entryWindow.makeKeyAndVisible()
        } else {
            entryWindow.isHidden = false
        }

        return entryVC
    }

    /** Boilerplate generic setup for entry-window and root-view-controller  */
    private func setupWindowAndRootVC() -> BEERootViewController {
        let entryVC: BEERootViewController
        if entryWindow == nil {
            let extractedExpr = BEERootViewController(with: self)
            entryVC = extractedExpr
            entryWindow = BEEWindow(with: entryVC)
            mainRollbackWindow = UIApplication.shared.keyWindow
        } else {
            entryVC = rootVC!
        }
        return entryVC
    }



    /**
     Privately used to display an entry
     */
    private func display(entryView: BEEEntryView, using attributes: BEEAttributes, presentInsideKeyWindow: Bool, rollbackWindow: BEEPopupKit.RollbackWindow) {
        switch entryView.attributes.precedence {
        case .override(priority: _, dropEnqueuedEntries: let dropEnqueuedEntries):
            if dropEnqueuedEntries {
                entryQueue.removeAll()
            }
            show(entryView: entryView, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow)
        case .enqueue where isCurrentlyDisplaying():
            entryQueue.enqueue(entry: .init(view: entryView, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow))
        case .enqueue:
            show(entryView: entryView, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow)
        }
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
    func transform(to view: UIView) {
        entryView?.transform(to: view)
    }

    /** Display a view using attributes */
    func display(view: UIView, using attributes: BEEAttributes, presentInsideKeyWindow: Bool, rollbackWindow: BEEPopupKit.RollbackWindow) {
        let entryView = BEEEntryView(newEntry: .init(view: view, attributes: attributes))
        display(entryView: entryView, using: attributes, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow)
    }

    /** Display a view controller using attributes */
    func display(viewController: UIViewController, using attributes: BEEAttributes, presentInsideKeyWindow: Bool, rollbackWindow: BEEPopupKit.RollbackWindow) {
        let entryView = BEEEntryView(newEntry: .init(viewController: viewController, attributes: attributes))
        display(entryView: entryView, using: attributes, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow)
    }

    /** Clear all entries immediately and display to the rollback window */
    func displayRollbackWindow() {
        if #available(iOS 13.0, *) {
            entryWindow.windowScene = nil
        }
        entryWindow = nil
        entryView = nil
        switch rollbackWindow! {
        case .main:
            if let mainRollbackWindow = mainRollbackWindow {
                mainRollbackWindow.makeKeyAndVisible()
            } else {
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
            }
        case .custom(window: let window):
            window.makeKeyAndVisible()
        }
    }

    /** Display a pending entry if there is any inside the queue */
    func displayPendingEntryOrRollbackWindow(dismissCompletionHandler: BEEPopupKit.DismissCompletionHandler?) {
        if let next = entryQueue.dequeue() {

            // Execute dismiss handler if needed before dequeuing (potentially) another entry
            dismissCompletionHandler?()

            // Show the next entry in queue
            show(entryView: next.view, presentInsideKeyWindow: next.presentInsideKeyWindow, rollbackWindow: next.rollbackWindow)
        } else {

            // Display the rollback window
            displayRollbackWindow()

            // As a last step, invoke the dismissal method
            dismissCompletionHandler?()
        }
    }

    /** Dismiss entries according to a given descriptor */
    func dismiss(_ descriptor: BEEPopupKit.EntryDismissalDescriptor, with completion: BEEPopupKit.DismissCompletionHandler? = nil) {
        guard let rootVC = rootVC else {
            return
        }

        switch descriptor {
        case .displayed:
            rootVC.animateOutLastEntry(completionHandler: completion)
        case .specific(entryName: let name):
            entryQueue.removeEntries(by: name)
            if entryView?.attributes.name == name {
                rootVC.animateOutLastEntry(completionHandler: completion)
            }
        case .prioritizedLowerOrEqualTo(priority: let priorityThreshold):
            entryQueue.removeEntries(withPriorityLowerOrEqualTo: priorityThreshold)
            if let currentPriority = entryView?.attributes.precedence.priority, currentPriority <= priorityThreshold {
                rootVC.animateOutLastEntry(completionHandler: completion)
            }
        case .enqueued:
            entryQueue.removeAll()
        case .all:
            entryQueue.removeAll()
            rootVC.animateOutLastEntry(completionHandler: completion)
        }
    }

    /** Layout the view-hierarchy rooted in the window */
    func layoutIfNeeded() {
        entryWindow?.layoutIfNeeded()
    }

    /** Privately used to prepare the root view controller and show the entry immediately */
    private func show(entryView: BEEEntryView, presentInsideKeyWindow: Bool, rollbackWindow: BEEPopupKit.RollbackWindow) {
        guard let entryVC = prepare(for: entryView.attributes, presentInsideKeyWindow: presentInsideKeyWindow) else {
            return
        }
        entryVC.configure(entryView: entryView)
        self.entryView = entryView
        self.rollbackWindow = rollbackWindow
    }
}
