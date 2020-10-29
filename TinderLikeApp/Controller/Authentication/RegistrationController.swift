//
//  RegistrationController.swift
//  TinderLikeApp
//
//  Created by Radhi Mighri on 28/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    //MARK:- Properties
    private var viewModel = RegistrationViewModel()
    
    private let selectPhotoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        btn.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        btn.clipsToBounds = true
        return btn
    }()
    
    private let emailTextField = CustomTextField(placeHolder: "Email")
    private let fullnameTextField = CustomTextField(placeHolder: "Full Name")
    private let passwordTextField = CustomTextField(placeHolder: "Password", isSecureField: true)
    
    private let authButton: AuthButton = {
        let btn = AuthButton(title: "Sign Up", type: .system)
        btn.addTarget(self, action: #selector(handleRegisterUser), for: .touchUpInside)
        return btn
    }()
    
    private let goToLoginButton: UIButton = {
        let btn = UIButton(type: .system)
        
        let attributedText = NSMutableAttributedString(string: "Already have an account ?", attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: " Sign In", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]))
        btn.setAttributedTitle(attributedText, for: .normal)
        btn.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
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
            } else if sender == passwordTextField {
                viewModel.password = sender.text
            } else {
                viewModel.fullname = sender.text
            }
//        print("DEBUG: Form is valid ? : \(viewModel.formIsValid)")
            checkFormStatus()
        }
    
    @objc func handleSelectPhoto() {
        print("DEBUG: Handle select photo here..")
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        let alert = UIAlertController(title: "FiTRi9i", message: "Select the pic source", preferredStyle: UIAlertController.Style.actionSheet)
        
        let camera = UIAlertAction(title: "Take a picture", style: UIAlertAction.Style.default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                picker.sourceType = .camera
                self.present(picker, animated: true, completion: nil)
            } else {
                print("DEBUG: Unavailable cam in the simulator")
            }
            
        }
        
        let library = UIAlertAction(title: "Choose an Image from your photoLibrary", style: UIAlertAction.Style.default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true, completion: nil)
            } else {
                print("DEBUG: Unavailable")
            }
        }

        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func handleRegisterUser() {
        print("DEBUG: Handle Sign up..")
    }
    
    @objc func handleShowLogin() {
        print("DEBUG: Handle Show login..")
        navigationController?.popViewController(animated: true)
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
        configureGradientLayer()
        
        view.addSubview(selectPhotoButton)
        selectPhotoButton.centerX(inView: view)
        selectPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        selectPhotoButton.setDimensions(height: 275, width: 275)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,fullnameTextField, passwordTextField, authButton])
            stack.axis = .vertical
            stack.spacing = 16
            
            view.addSubview(stack)
            stack.anchor(top: selectPhotoButton.bottomAnchor, left: view.leftAnchor,
                         right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingRight: 32)
        
            view.addSubview(goToLoginButton)
            goToLoginButton.anchor(left: view.leftAnchor,
                                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                          right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
    }
    
    func configureTextFieldObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

    }
}


extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedSelectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectPhotoButton.setImage(editedSelectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            selectPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
            selectPhotoButton.layer.borderWidth = 3
            selectPhotoButton.layer.cornerRadius = 10
            selectPhotoButton.imageView?.contentMode = .scaleAspectFill
//            image = editedSelectedImage
        }
        
        if let originalSelectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectPhotoButton.setImage(originalSelectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            selectPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
            selectPhotoButton.layer.borderWidth = 3
            selectPhotoButton.layer.cornerRadius = 10
            selectPhotoButton.imageView?.contentMode = .scaleAspectFill
//            image = originalSelectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
