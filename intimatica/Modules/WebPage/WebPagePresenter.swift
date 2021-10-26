//
//  WebPagePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/14/21.
//

import Foundation
import Apollo
import FirebaseAnalytics

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
    private let useCase: GraphQLUseCaseProtocol
    private let query: T
    weak var view: WebPageViewProtocol?
    
    // MARK: - Initializers
    init(dependencies: UseCaseProviderProtocol, graphQLQuery: T) {
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
                if let termsData = graphQLResult.data as? TermsQuery.Data,
                   let content = termsData.term?.content {
                    self.view?.display(content)
                    FirebaseAnalytics.Analytics.logEvent(AnalyticsEventScreenView, parameters: ["name": "Terms"])
                } else if let conditionsData = graphQLResult.data as? ConditionsQuery.Data,
                          let content = conditionsData.condition?.content {
                    self.view?.display(content)
                    FirebaseAnalytics.Analytics.logEvent(AnalyticsEventScreenView, parameters: ["name": "Conditions"])
                } else if let premiumData = graphQLResult.data as? PremiumDescriptionQuery.Data,
                          let content = premiumData.premiumDescription?.content {
                    self.view?.display(content)
                    FirebaseAnalytics.Analytics.logEvent(AnalyticsEventScreenView, parameters: ["name": "PremiumDescription"])
                } else if let helpData = graphQLResult.data as? HelpPageQuery.Data,
                          let content = helpData.helpPage?.content {
                    self.view?.display(content)
                    FirebaseAnalytics.Analytics.logEvent(AnalyticsEventScreenView, parameters: ["name": "HelpPage"])
                } else if let aboutData = graphQLResult.data as? AboutPageQuery.Data,
                          let content = aboutData.aboutPage?.content {
                    self.view?.display(content)
                    FirebaseAnalytics.Analytics.logEvent(AnalyticsEventScreenView, parameters: ["name": "AboutPage"])
                } else if let termsAndConditionsData = graphQLResult.data as? TermsAndConditionsPageQuery.Data,
                          let content = termsAndConditionsData.termsAndConditionsPage?.content {
                    self.view?.display(content)
                    FirebaseAnalytics.Analytics.logEvent(AnalyticsEventScreenView, parameters: ["name": "TermsAndConditionsPage"])
                } else if let privacyPolicyPageData = graphQLResult.data as? PrivacyPolicyPageQuery.Data,
                          let content = privacyPolicyPageData.privacyPolicyPage?.content {
                    self.view?.display(content)
                    FirebaseAnalytics.Analytics.logEvent(AnalyticsEventScreenView, parameters: ["name": "PrivacyPolicyPage"])
                }else {
                    fatalError("Content not found")
                }
            case .failure(let error):
                self.view?.displayError(error.localizedDescription)
            }
        }
    }
}
