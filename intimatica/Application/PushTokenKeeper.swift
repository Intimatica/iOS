//
//  PushTokenKeeper.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/9/21.
//

import Foundation

class PushTokenKeeper {
    public static let sharedInstance = PushTokenKeeper()
    public var token: String?
}
