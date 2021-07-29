//
//  TheoryTableViewCell.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/29/21.
//

import UIKit

class TheoryTableViewCell: BaseTableViewCell {
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lauout
    func setupUI() {
        addPostLabel(text: L10n("TABLE_CELL_POST_LABEL_THEORY"), backGroundColor: Constants.postLabelColor)
    }
}

// MARK: - Constants/Helper
extension TheoryTableViewCell {
    struct Constants {
        static var postLabelColor: UIColor = .init(hex: 0xFF9900)
    }
}
