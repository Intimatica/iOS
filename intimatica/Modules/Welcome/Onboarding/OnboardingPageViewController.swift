
import UIKit

class OnboardingPageViewController: UIViewController {
    var index: Int = 0
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    class func instance(with index: Int) -> OnboardingPageViewController {
        let sb = UIStoryboard(name: "Storyboard", bundle: nil)
        let vc: OnboardingPageViewController = sb.instantiateViewController(withIdentifier: "OnboardingPageViewController") as! OnboardingPageViewController
        vc.index = index
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.font = UIFont(name: "Rubik-Bold", size: 40)
        descriptionLabel.font = UIFont(name: "Rubik-Regular", size: 18)
        
        imageView.image = UIImage(named: "onboard_back_\(index)")
        titleLabel.text = NSLocalizedString("ONBOARD_TITLE_\(index)", comment: "")
        descriptionLabel.text = NSLocalizedString("ONBOARD_DESCRIPTION_\(index)", comment: "")
    }
}
