//
//  UserDefaultsSevice.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/15/21.
//

import Foundation

protocol FavoritesSeviceProtocol {
    func get() -> Set<String>
    func add(_ id: String)
    func remove(_ id: String)
}

protocol HasFavoriteServiceProtocol {
    var favoriteService: FavoritesSeviceProtocol { get }
}

final class FavoritesSevice: FavoritesSeviceProtocol {
    private let defaults = UserDefaults.standard
    private let key = "post_favorites"
    
    func add(_ id: String) {
        var data = get()
        data.insert(id)
        set(data)
    }
    
    func remove(_ id: String) {
        var data = get()
        data.remove(id)
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
