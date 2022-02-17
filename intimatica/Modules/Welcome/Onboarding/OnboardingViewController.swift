
import UIKit

class OnboardingViewController: UIViewController {
    private var presenter: OnboardingPresenterProtocol!
    private var pageController: UIPageViewController?
    private let numberOfPages: Int = 3
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    @IBOutlet var goButton: UIButton!
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.pageController?.goToPreviousPage(with: {[weak self] _ in
            self?.updateUI()
        })
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        presenter.skipButtonDidTap()
    }
    
    @IBAction func goButtonTapped(_ sender: Any) {
        guard let currentViewController: OnboardingPageViewController = self.pageController?.viewControllers?.first as? OnboardingPageViewController else { return }
        if currentViewController.index == 2 {
            presenter.goButtonDidTap()
        } else {
            self.pageController?.goToNextPage(with: {[weak self] _ in
                self?.updateUI()
            })
        }
    }
    
    class func instance(with presenter: OnboardingPresenterProtocol) -> OnboardingViewController {
        let sb = UIStoryboard(name: "Storyboard", bundle: nil)
        let vc: OnboardingViewController = sb.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        vc.presenter = presenter
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goButton.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 16)
        skipButton.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 16)
        skipButton.setTitle(NSLocalizedString("ONBOARD_BUTTON_SKIP", comment: ""), for: .normal)
        setupPageController()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func updateUI(){
        guard let currentViewController: OnboardingPageViewController = self.pageController?.viewControllers?.first as? OnboardingPageViewController else { return }
        backButton.isHidden = currentViewController.index == 0
        let titleKey = currentViewController.index == 2 ? "ONBOARD_BUTTON_GO" : "ONBOARD_BUTTON_NEXT"
        UIView.performWithoutAnimation {
            goButton.setTitle(NSLocalizedString(titleKey, comment: ""), for: .normal)
            goButton.layoutIfNeeded()
        }
    }
    
    private func setupPageController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.addChild(self.pageController!)
        self.view.insertSubview(self.pageController!.view, at: 0)
        
        let initialVC = OnboardingPageViewController.instance(with: 0)
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        
        self.pageController?.didMove(toParent: self)
    }
}

extension UIPageViewController {
    func goToNextPage(with completion: ((Bool) -> Void)?) {
       guard let currentViewController = self.viewControllers?.first else { return }
       guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
       setViewControllers([nextViewController], direction: .forward, animated: true, completion: completion)
    }

    func goToPreviousPage(with completion: ((Bool) -> Void)?) {
       guard let currentViewController = self.viewControllers?.first else { return }
       guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return }
       setViewControllers([previousViewController], direction: .reverse, animated: true, completion: completion)
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingPageViewController else {
            return nil
        }
        
        var index = currentVC.index
        
        if index == 0 {
            return nil
        }
        
        index -= 1
                
        let vc: OnboardingPageViewController = OnboardingPageViewController.instance(with: index)
                
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingPageViewController else {
            return nil
        }
        
        var index = currentVC.index
        
        if index >= numberOfPages - 1 {
            return nil
        }
        
        index += 1
        
        let vc: OnboardingPageViewController = OnboardingPageViewController.instance(with: index)
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        updateUI()
    }
}

