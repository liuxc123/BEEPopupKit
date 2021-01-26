//
//  BEEPopup.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import UIKit

/**
 A stateless, threadsafe (unless described otherwise) entry point that contains the display and the dismissal logic of entries.
 */
public final class BEEPopupKit {

    /** Describes the a single or multiple entries for possible dismissal states */
    public enum EntryDismissalDescriptor {

        /** Describes specific entry / entries with name */
        case specific(entryName: String)

        /** Describes a group of entries with lower or equal display priority */
        case prioritizedLowerOrEqualTo(priority: BEEAttributes.Precedence.Priority)

        /** Describes all the entries that are currently in the queue and pending presentation */
        case enqueued

        /** Describes all the entries */
        case all

        /** Describes the currently displayed entry */
        case displayed
    }

    /** The window to rollback to after dismissal */
    public enum RollbackWindow {

        /** The main window */
        case main

        /** A given custom window */
        case custom(window: UIWindow)
    }

    /** Completion handler for the dismissal method */
    public typealias DismissCompletionHandler = () -> Void

    /** Cannot be instantiated, customized, inherited. */
    private init() {}

    /**
     Returns the window that displays the entry.
     **Warning**: the returned `UIWindow` instance is `nil` in case
     no entry is currently displayed.
     This can be used
     */
    public class var window: UIWindow? {
        return BEEWindowProvider.shared.entryWindow
    }
    
    /**
     Returns true if **any** entry is currently displayed.
     - Not thread safe - should be called from the main queue only in order to receive a reliable result.
     - Convenience computed variable. Using it is the same as invoking **isCurrentlyDisplaying() -> Bool** (witohut the name of the entry).
     */
    public class var isCurrentlyDisplaying: Bool {
        return isCurrentlyDisplaying()
    }

    /**
     Returns true if an entry with a given name is currently displayed.
     - Not thread safe - should be called from the main queue only in order to receive a reliable result.
     - If invoked with *name* = *nil* or without the parameter value, it will return *true* if **any** entry is currently displayed.
     - Returns a *false* value for currently enqueued entries.
     - parameter name: The name of the entry. Its default value is *nil*.
     */
    public class func isCurrentlyDisplaying(entryNamed name: String? = nil) -> Bool {
        return BEEWindowProvider.shared.isCurrentlyDisplaying(entryNamed: name)
    }

    /**
     Returns true if **any** entry is currently enqueued and waiting to be displayed.
     - Not thread safe - should be called from the main queue only in order to receive a reliable result.
     - Convenience computed variable. Using it is the same as invoking **~queueContains() -> Bool** (witohut the name of the entry)
     */
    public class var isQueueEmpty: Bool {
        return !queueContains()
    }

    /**
     Returns true if an entry with a given name is currently enqueued and waiting to be displayed.
     - Not thread safe - should be called from the main queue only in order to receive a reliable result.
     - If invoked with *name* = *nil* or without the parameter value, it will return *true* if **any** entry is currently displayed, meaning, the queue is not currently empty.
     - parameter name: The name of the entry. Its default value is *nil*.
     */
    public class func queueContains(entryNamed name: String? = nil) -> Bool {
        return BEEWindowProvider.shared.queueContains(entryNamed: name)
    }

    /**
     Displays a given entry view using an attributes struct.
     - A thread-safe method - Can be invokes from any thread
     - A class method - Should be called on the class
     - parameter view: Custom view that is to be displayed
     - parameter attributes: Display properties
     - parameter presentInsideKeyWindow: Indicates whether the entry window should become the key window.
     - parameter rollbackWindow: After the entry has been dismissed, BEEPopupKit rolls back to the given window. By default it is *.main* which is the app main window
     */
    public class func display(entry view: UIView, using attributes: BEEAttributes, presentInsideKeyWindow: Bool = false, rollbackWindow: RollbackWindow = .main) {
        DispatchQueue.main.async {
            BEEWindowProvider.shared.display(view: view, using: attributes, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow)
        }
    }

    public class func display(entry view: UIView, using attributes: BEEAttributes, presentView: UIView) {
        DispatchQueue.main.async {
            let popup = BEEPopup(to: presentView)
            popup.display(entry: view, using: attributes)
        }
    }

    /**
     Displays a given entry view controller using an attributes struct.
     - A thread-safe method - Can be invokes from any thread
     - A class method - Should be called on the class
     - parameter view: Custom view that is to be displayed
     - parameter attributes: Display properties
     - parameter presentInsideKeyWindow: Indicates whether the entry window should become the key window.
     - parameter rollbackWindow: After the entry has been dismissed, BEEPopupKit rolls back to the given window. By default it is *.main* - which is the app main window
     */
    public class func display(entry viewController: UIViewController, using attributes: BEEAttributes, presentInsideKeyWindow: Bool = false, rollbackWindow: RollbackWindow = .main) {
        DispatchQueue.main.async {
            BEEWindowProvider.shared.display(viewController: viewController, using: attributes, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow)
        }
    }

    public class func display(entry viewController: UIViewController, using attributes: BEEAttributes, presentView: UIView) {
        DispatchQueue.main.async {
            let popup = BEEPopup(to: presentView)
            popup.display(entry: viewController, using: attributes)
        }
    }

    /**
     ALPHA FEATURE: Transform the previous entry to the current one using the previous attributes struct.
     - A thread-safe method - Can be invoked from any thread.
     - A class method - Should be called on the class.
     - This feature hasn't been fully tested. Use with caution.
     - parameter view: Custom view that is to be displayed instead of the currently displayed entry
     */
    public class func transform(to view: UIView) {
        DispatchQueue.main.async {
            BEEWindowProvider.shared.transform(to: view)
        }
    }

    /**
     Dismisses the currently presented entry and removes the presented window instance after the exit animation is concluded.
     - A thread-safe method - Can be invoked from any thread.
     - A class method - Should be called on the class.
     - parameter descriptor: A descriptor for the entries that are to be dismissed. The default value is *.displayed*.
     - parameter completion: A completion handler that is to be called right after the entry is dismissed (After the animation is concluded).
     */
    public class func dismiss(_ descriptor: EntryDismissalDescriptor = .displayed, with completion: DismissCompletionHandler? = nil) {
        DispatchQueue.main.async {
            BEEWindowProvider.shared.dismiss(descriptor, with: completion)
        }
    }

    public class func dismiss(form presentView: UIView, descriptor: BEEPopupKit.EntryDismissalDescriptor = .displayed, with completion: BEEPopupKit.DismissCompletionHandler? = nil) {
        DispatchQueue.main.async {
            presentView.popups.forEach({ $0.provider.dismiss(descriptor, with: nil) })
        }
    }

    /**
     Layout the view hierarchy that is rooted in the window.
     - In case you use complex animations, you can call it to refresh the AutoLayout mechanism on the entire view hierarchy.
     - A thread-safe method - Can be invoked from any thread.
     - A class method - Should be called on the class.
     */
    public class func layoutIfNeeded() {
        if Thread.isMainThread {
            BEEWindowProvider.shared.layoutIfNeeded()
        } else {
            DispatchQueue.main.async {
                BEEWindowProvider.shared.layoutIfNeeded()
            }
        }
    }
    
    public class func popups(from presentView: UIView) -> [BEEPopup] {
        return presentView.popups
    }
}

public final class BEEPopup: NSObject {
 
    /** Current entry presentView */
    var provider: BEEViewProvider!
    
    /** Cannot be instantiated, customized, inherited */
    public init(to presentView: UIView) {
        self.provider = BEEViewProvider(presentView: presentView)
    }

    public var isCurrentlyDisplaying: Bool {
        return isCurrentlyDisplaying()
    }

    public func isCurrentlyDisplaying(entryNamed name: String? = nil) -> Bool {
        return provider.isCurrentlyDisplaying(entryNamed: name)
    }

    public var isQueueEmpty: Bool {
        return !queueContains()
    }

    public func queueContains(entryNamed name: String? = nil) -> Bool {
        return provider.queueContains(entryNamed: name)
    }

    public func display(entry view: UIView, using attributes: BEEAttributes) {
        DispatchQueue.main.async {
            let entryView = BEEEntryView(newEntry: .init(view: view, attributes: attributes))
            self.appendToPresentView()
            self.provider.display(entryView: entryView, using: attributes)
        }
    }
    
    public func display(entry viewController: UIViewController, using attributes: BEEAttributes) {
        DispatchQueue.main.async {
            let entryView = BEEEntryView(newEntry: .init(viewController: viewController, attributes: attributes))
            self.appendToPresentView()
            self.provider.display(entryView: entryView, using: attributes)
        }
    }
    
    public func dismiss(_ descriptor: BEEPopupKit.EntryDismissalDescriptor = .displayed, with completion: BEEPopupKit.DismissCompletionHandler? = nil) {
        DispatchQueue.main.async {
            self.provider.dismiss(descriptor, with: completion)
        }
    }

    private func appendToPresentView() {
        if !self.provider.presentView.popups.contains(where: { [weak self] popup in
            guard let self = self else { return false }
            return popup == self
        }) {
            provider.presentView.popups.append(self)
        }
    }
}


