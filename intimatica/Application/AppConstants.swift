//
//  AppConstants.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/19/21.
//

import Foundation
import Kingfisher

struct AppConstants {
    static let serverURL = "https://intimatica.key42.net"
    static let kingFisherOptions: KingfisherOptionsInfo = [
        .diskCacheExpiration(.seconds(TimeInterval(15 * 60)))
    ]
}
