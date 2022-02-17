
import Foundation
import XCoordinator

protocol OnboardingPresenterProtocol {
    func skipButtonDidTap()
    func goButtonDidTap()
}

final class OnboardingPresenter {
    // MARK: - Properties
    private let router: AppRouter!
    
    // MARK: - Initializers
    init(router: AppRouter) {
        self.router = router
    }
}

// MARK: - OnboardingPresenterProtocol
extension OnboardingPresenter: OnboardingPresenterProtocol {
    func skipButtonDidTap() {
        router.trigger(.ageConfirm)
    }
    
    func goButtonDidTap() {
        router.trigger(.ageConfirm)
    }
}
