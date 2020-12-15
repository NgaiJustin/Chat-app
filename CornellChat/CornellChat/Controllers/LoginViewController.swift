//
//  LoginViewController.swift
//  CornellChat
//
//  Created by Justin Ngai on 8/12/2020.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class LoginViewController: UIViewController {
    private let spinner = JGProgressHUD(style: .dark)
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let netidField: UITextField = {
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
    
    private let passwordField: UITextField = {
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector (loginButtonTapped), for: .touchUpInside)
        
        // Prettify
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if User.current != nil {
            let newvc = ViewController()
            self.navigationController?.pushViewController(newvc, animated: true)
        }
        
        // Make navigation bar translucent
        self.navigationController?.view.backgroundColor = .clear
        
        // Nice background
        let img = UIImage(named: "cornell2")!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),                                                              resizingMode: .stretch)
        scrollView.backgroundColor = UIColor(patternImage: img)
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = scrollView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.addSubview(blurEffectView)
        
        title = "Log in"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        netidField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(netidField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        logoImageView.frame = CGRect(x: (scrollView.width - size)/2,
                                     y: 20,
                                     width: size,
                                     height: size)
        netidField.frame = CGRect(x: 30,
                                  y: logoImageView.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                  y: netidField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        loginButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom + 10,
                                   width: scrollView.width - 60,
                                   height: 52)
    }
    
    @objc private func loginButtonTapped(){
        
        // Remove keyboard
        netidField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let netid = netidField.text, let pw = passwordField.text,
              !netid.isEmpty, !pw.isEmpty else {
                loginError()
                return
        }
        
        spinner.show(in: view)
        NetworkManager.login(username: netid, password: pw) { (user) in
            self.spinner.dismiss()
            User.current = user
            let newvc = ViewController()
            self.navigationController?.pushViewController(newvc, animated: true)
            
        }
        // Sign user in based on their netid
        // Weak self to prevent memory leak -- just a little better
//        FirebaseAuth.Auth.auth().signIn(withEmail: "\(netid)@cornell.edu", password: pw, completion: {[weak self] authResult, error in
//            guard let ss = self else {
//                return
//            }
//            DispatchQueue.main.async {
//                ss.spinner.dismiss()
//            }
//            guard let result = authResult, error == nil else {
//                print("Could not log in user with netid: \(netid)")
//                return
//            }
//            let user = result.user
//            print("Successful log in \(user)")
//
//            // SET TOKEN HERE
//            UserDefaults.standard.set("token", forKey: "something")
//
//            ss.navigationController?.dismiss(animated: true, completion: nil)
//        })
        
        // UserDefaults.standard.setValue(true, forKey: "logged_in")
        // dismiss(animated: true, completion: nil) // fix this later, for now we want to see the next screen
    }
    
    func loginError(){
        let alert = UIAlertController(title: "Oh no!",
                                      message: "Please enter a valid NetID and password",
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// Field validation here
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == netidField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            loginButtonTapped()
        }
        return true
    }
}
    
