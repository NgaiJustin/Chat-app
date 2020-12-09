//
//  RegisterViewController.swift
//  CornellChat
//
//  Created by Justin Ngai on 8/12/2020.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let profilePicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .systemPink
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    let netidField: UITextField = {
        let field = UITextField()
        field.placeholder = "NetID..."
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        
        // Bump text left a little
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password..."
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        
        // Bump text left a little
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        
        return field
    }()
    
    let firstNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "First Name..."
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        
        // Bump text left a little
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
    }()
    
    let lastNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Last Name..."
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        
        // Bump text left a little
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemTeal
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        // Prettify
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        netidField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(profilePicImageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(netidField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        profilePicImageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(didTapChangeProfilePic))
        profilePicImageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangeProfilePic(){
        print("Change pic later!!!")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        profilePicImageView.frame = CGRect(x: (scrollView.width - size)/2,
                                     y: 20,
                                     width: size,
                                     height: size)
        firstNameField.frame = CGRect(x: 30,
                                  y: profilePicImageView.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        lastNameField.frame = CGRect(x: 30,
                                  y: firstNameField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        netidField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: netidField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        registerButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom + 10,
                                   width: scrollView.width - 60,
                                   height: 52)
    }
    
    @objc private func registerButtonTapped(){
        // Remove keyboard
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        netidField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let netid = netidField.text,
              let pw = passwordField.text,
              let first = firstNameField.text,
              let last = lastNameField.text,
              !netid.isEmpty,
              !pw.isEmpty,
              !first.isEmpty,
              !last.isEmpty else {
                registerError()
                return
        }
        // Login with backend
    }
    
    func registerError(){
        let alert = UIAlertController(title: "Oh no!",
                                      message: "Please enter all information to create a new account",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:"Dismiss",
                                      style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister(){
        let vc = RegisterViewController()
        vc.title = "Sign Up"
        navigationController?.pushViewController(vc, animated: true)
    }
}

// Field validation here
extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == netidField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            registerButtonTapped()
        }
        return true
    }
}

