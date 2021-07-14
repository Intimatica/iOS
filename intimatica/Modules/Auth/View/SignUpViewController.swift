//
//  SignUpViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK: - Properties
    
    var pageTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = l10n("SING_UP_TITLE")
        label.text = "Registration"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    var emailField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Layout
    private func setupUI() {
        
    }
    
}
