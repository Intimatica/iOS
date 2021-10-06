//
//  BackBarButtonItem.swift
//  intimatica
//
//  Created by Andrey RustFox on 10/6/21.
//

import UIKit

class BackBarButtonItem: UIBarButtonItem {
    override init() {
        super.init()
        
        setBackgroundImage(UIImage(named: "back_button"), for: .normal, barMetrics: .default)
        setBackButtonBackgroundImage(UIImage(named: "back_button"), for: .normal, barMetrics: .default)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
