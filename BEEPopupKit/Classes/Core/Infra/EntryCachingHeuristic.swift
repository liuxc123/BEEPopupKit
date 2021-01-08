//
//  EntryCachingHeuristic.swift
//  BEEPopupKit
//
//  Created by liuxc on 2021/1/7.
//

import Foundation

struct CachedEntry {
    let view: BEEEntryView
    let presentInsideKeyWindow: Bool
    let rollbackWindow: BEEPopupKit.RollbackWindow
}

protocol EntryCachingHeuristic: class {
    var entries: [CachedEntry] { set get }
    var isEmpty: Bool { get }

    func dequeue() -> CachedEntry?
    func enqueue(entry: CachedEntry)

    func removeEntries(by name: String)
    func removeEntries(withPriorityLowerOrEqualTo priority: BEEAttributes.Precedence.Priority)
    func remove(entry: CachedEntry)
    func removeAll()

    func contains(entryNamed name: String) -> Bool
}

extension EntryCachingHeuristic {

    var isEmpty: Bool {
        return entries.isEmpty
    }

    func contains(entryNamed name: String) -> Bool {
        return entries.contains { $0.view.attributes.name == name }
    }

    func dequeue() -> CachedEntry? {
        guard let first = entries.first else {
            return nil
        }
        entries.removeFirst()
        return first
    }

    func removeEntries(withPriorityLowerOrEqualTo priority: BEEAttributes.Precedence.Priority) {
        while let index = (entries.firstIndex { $0.view.attributes.precedence.priority <= priority }) {
            entries.remove(at: index)
        }
    }

    func removeEntries(by name: String) {
        while let index = (entries.firstIndex { $0.view.attributes.name == name }) {
            entries.remove(at: index)
        }
    }

    func remove(entry: CachedEntry) {
        guard let index = (entries.firstIndex { $0.view == entry.view }) else {
            return
        }
        entries.remove(at: index)
    }

    func removeAll() {
        entries.removeAll()
    }
}

class BEEEntryChronologicalQueue: EntryCachingHeuristic {

    var entries: [CachedEntry] = []

    func enqueue(entry: CachedEntry) {
        entries.append(entry)
    }
}

class BEEEntryPriorityQueue: EntryCachingHeuristic {

    var entries: [CachedEntry] = []

    func enqueue(entry: CachedEntry) {
        let entryPriority = entry.view.attributes.precedence.priority
        let index = entries.firstIndex {
            return entryPriority > $0.view.attributes.precedence.priority
        }
        if let index = index {
            entries.insert(entry, at: index)
        } else {
            entries.append(entry)
        }
    }
}

