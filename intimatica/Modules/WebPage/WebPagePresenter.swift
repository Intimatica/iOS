//
//  WebPagePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/14/21.
//

import Foundation

protocol WebPageViewProtocol: AnyObject {
    func display(_ text: String)
    func displayError(_ message: String)
}

protocol WebPagePresenterProtocol {
    func viewDidLoad()
}

final class WebPagePresenter {
    enum Page {
        case terms, conditions
    }
    
    // MARK: - Properties
    private let router: Router
    private let useCase: GraphQLUseCaseProtocol
    private let page: Page
    weak var view: WebPageViewProtocol?
    
    // MARK: - Initializers
    init(router: Router, dependencies: UseCaseProviderProtocol, page: Page) {
        self.router = router
        self.useCase = dependencies.graphQLUseCase
        self.page = page
    }
}

// MARK: - WebPagePresenterProtocol
extension WebPagePresenter: WebPagePresenterProtocol {
    func viewDidLoad() {
        
        // QUESTION: try to refactor
        switch page {
        case .terms:
            useCase.fetch(query: TermsQuery()) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let graphQLResult):
                    if let content = graphQLResult.data?.term?.content {
                        self.view?.display(content)
                    } // TODO: add error processing
                case .failure(let error):
                    self.view?.displayError(error.localizedDescription)
                }
            }
            
        case .conditions:
            useCase.fetch(query: ConditionsQuery()) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let graphQLResult):
                    if let content = graphQLResult.data?.condition?.content {
                        self.view?.display(content)
                    } // TODO: add error processing
                case .failure(let error):
                    self.view?.displayError(error.localizedDescription)
                }
            }
        }
    }
}

