//
//  AppConstants.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/19/21.
//

import Foundation
import Kingfisher

struct AppConstants {
    static var serverURL: String!
    static let kingFisherOptions: KingfisherOptionsInfo = [
        .diskCacheExpiration(.seconds(TimeInterval(15 * 60)))
    ]
    static var displayPremiumButton: Bool!
}
