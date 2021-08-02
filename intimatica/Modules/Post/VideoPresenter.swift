//
//  VideoPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/2/21.
//

import Foundation

protocol VideoViewProtocol: AnyObject {
    func display()
}

protocol VideoPresenterProtocol: BasePresenterProtocol {
}

final class VideoPresenter: BasePresenter {
    // MARK: - Properties
    weak var view: VideoViewProtocol?
}

// MARK: - VideoViewProtocol
extension VideoPresenter: VideoPresenterProtocol {
    func viewDidLoad() {
        
    }
}
