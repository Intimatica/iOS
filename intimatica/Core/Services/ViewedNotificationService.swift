//
//  ViewedNotificationService.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/15/21.
//
import Foundation

protocol ViewedNotificationsServiceProtocol {
    func get() -> Set<String>
    func add(_ id: String)
}

protocol HasViewedNotificationsServiceProtocol {
    var viewedNotificationsService: ViewedNotificationsServiceProtocol { get }
}

final class ViewedNotificationsService: ViewedNotificationsServiceProtocol {
    private let defaults = UserDefaults.standard
    private let key = "viewed_notifications"
    
    func add(_ id: String) {
        var data = get()
        data.insert(id)
        set(data)
    }
    
    func get() -> Set<String> {
        let data = defaults.string(forKey: key) ?? ""
        return Set(data.components(separatedBy: ",").compactMap { $0 }.filter { !$0.isEmpty })
    }
    
    func set(_ set: Set<String>) {
        defaults.set(set.joined(separator: ","), forKey: key)
    }
}
