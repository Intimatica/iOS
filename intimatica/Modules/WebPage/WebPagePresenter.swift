//
//  WebPagePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/14/21.
//

import Foundation
import Apollo

protocol WebPageViewProtocol: AnyObject {
    func display(_ text: String)
    func displayError(_ message: String)
}

protocol WebPagePresenterProtocol {
    func viewDidLoad()
}

final class WebPagePresenter<T: GraphQLQuery> {
    enum Page {
        case terms, conditions
    }
    
    // MARK: - Properties
    private let router: Router
    private let useCase: GraphQLUseCaseProtocol
    private let query: T
    weak var view: WebPageViewProtocol?
    
    // MARK: - Initializers
    init(router: Router, dependencies: UseCaseProviderProtocol, graphQLQuery: T) {
        self.router = router
        self.useCase = dependencies.graphQLUseCase
        self.query = graphQLQuery
    }
}

// MARK: - WebPagePresenterProtocol
extension WebPagePresenter: WebPagePresenterProtocol {
    func viewDidLoad() {

        useCase.fetch(query: query) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQLResult):
                
                // QUESTION: try to refactor
                if let termsData = ((graphQLResult.data) as? TermsQuery.Data), let content = termsData.term?.content {
                    self.view?.display(content)
                } else if let conditionsData = ((graphQLResult.data) as? ConditionsQuery.Data), let content = conditionsData.condition?.content {
                    self.view?.display(content)
                } else {
                    fatalError("Content not found")
                }
            case .failure(let error):
                self.view?.displayError(error.localizedDescription)
            }
        }
    }
}

