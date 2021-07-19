//
//  StorageService.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/19/21.
//

import Foundation

protocol StorageService {
    func storeEmail(_: String)
    func getEmail() -> String
    func storePassword(_: String)
    func getPassword() -> String
    func storeAccessToken(_: String)
    func getAccessToken(_: String)
}
