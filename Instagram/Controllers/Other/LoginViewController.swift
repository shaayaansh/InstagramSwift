//
//  LoginViewController.swift
//  Instagram
//
//  Created by shayan shokri on 11/3/20.
//  Copyright © 2020 SHAYI. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.white ,for: .normal)
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Create Account", for: .normal)
        
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        header.backgroundColor = .orange
        return header
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = UIColor.systemBackground
                
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        headerView.frame = CGRect(x: 0, y: 0.0, width: view.width, height: view.height/4.0)
        usernameEmailField.frame = CGRect(x: 25, y: headerView.bottom + 20, width: view.width-50, height: 52.0)
        passwordField.frame = CGRect(x: 25, y: usernameEmailField.bottom + 20, width: view.width-50, height: 52.0)
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 20, width: view.width-50, height: 52)
        createAccountButton.frame = CGRect(x: 45, y: loginButton.bottom + 20, width: view.width-50, height: 52)
        configureHeaderView()
    }
    
    private func addSubviews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    private func configureHeaderView(){
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: view.width * 0.4 , y:view.safeAreaInsets.top, width: view.width/5.0, height: headerView.height)
    }
    
    @objc private func didTapLoginButton(){
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
    
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
            let password = passwordField.text, !password.isEmpty, password.count >= 8 else{
                return
        }
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains("."){
            email = usernameEmail
        }
        else{
            username = usernameEmail
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: password){success in
            DispatchQueue.main.async {
                if success {
                    //user logged in
                    self.dismiss(animated: true, completion: nil)
                } else {
                    //error occurred
                    let alert = UIAlertController(title: "Login Error",
                                                  message: "We were unable to log you in",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .cancel,
                                                  handler: nil))
                    self.present(alert, animated: true)
                }
            }
            
        }
    }
    @objc private func didTapCreateButton(){
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    

}
