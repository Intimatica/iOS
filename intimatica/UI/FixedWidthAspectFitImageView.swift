//
//  FixedWidthImageView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/30/21.
//

import UIKit

class FixedWidthAspectFitImageView: UIImageView
{
    override var intrinsicContentSize: CGSize
    {
        let frameSizeWidth = self.frame.size.width

        guard let image = self.image else {
            return CGSize(width: frameSizeWidth, height: 1.0)
        }

        let returnHeight = ceil(image.size.height * (frameSizeWidth / image.size.width))
        return CGSize(width: frameSizeWidth, height: returnHeight)
    }
}
