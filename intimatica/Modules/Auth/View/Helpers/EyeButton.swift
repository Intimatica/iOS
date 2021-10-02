//
//  ShowPasswordButton.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/21/21.
//

import UIKit

class EyeButton: UIButton {
    //MARK: - Properties
    enum ImageState {
        case inactive
        case active
        case insecure
    }
    
    private var imageStateKeeper: ImageState = .inactive
    
    var backgroundImageState: ImageState {
        set {
            changeImage(to: newValue)
            imageStateKeeper = newValue
        }
        get {
            return imageStateKeeper
        }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        changeImage(to: .inactive)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleSecure() {
        guard imageStateKeeper != .inactive else { return }
        
        imageStateKeeper = imageStateKeeper == .active ? .insecure : .active
        changeImage(to: imageStateKeeper)
    }
    
    private func changeImage(to imageState: ImageState) {
        switch(imageState) {
        case .inactive:
            setBackgroundImage(UIImage(named: "password_hidden_inactive"), for: .normal)
        case .active:
            setBackgroundImage(UIImage(named: "password_hidden_active"), for: .normal)
        case .insecure:
            setBackgroundImage(UIImage(named: "password_visable_active"), for: .normal)
        }
    }
}
