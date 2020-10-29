//
//  LoginController.swift
//  TinderLikeApp
//
//  Created by Radhi Mighri on 28/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK:- Properties
    private var viewModel = LoginViewModel()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        return iv
    }()
    
    private let emailTextField = CustomTextField(placeHolder: "Email")
    
    private let passwordTextField = CustomTextField(placeHolder: "Password", isSecureField: true)
    
    private let authButton: AuthButton = {
        let btn = AuthButton(title: "Log In", type: .system)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    private let goToRegistrationButton: UIButton = {
        let btn = UIButton(type: .system)
        
        let attributedText = NSMutableAttributedString(string: "Don't have an account yet ?", attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: " Sign Up", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]))
        btn.setAttributedTitle(attributedText, for: .normal)
        btn.addTarget(self, action: #selector(handleShowRegistration), for: .touchUpInside)
        return btn
    }()
    

    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldObservers()
        configureUI()
    }
    
    //MARK:- Actions (Selectors)
    @objc func textDidChange(sender: UITextField) {
//        print("DEBUG: TextField text is : \(sender.text)")
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
//    print("DEBUG: Form is valid ? : \(viewModel.formIsValid)")
        checkFormStatus()
    }
    
    @objc func handleLogin() {
        
    }
    @objc func handleShowRegistration() {
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    //MARK:- Helpers Functions
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            authButton.isEnabled = true
            authButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            authButton.isEnabled = false
            authButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.setDimensions(height: 100, width: 100)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, authButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: iconImageView.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingRight: 32)
    
        view.addSubview(goToRegistrationButton)
        goToRegistrationButton.anchor(left: view.leftAnchor,
                                      bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                      right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
    
    }

    
    func configureTextFieldObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

    }
}
