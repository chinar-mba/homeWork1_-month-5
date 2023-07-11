//
//  AuthorizationViewController.swift
//  homeWork1
//
//  Created by Chinara on 7/5/23.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    private let loginLabel: UILabel = {
        let view = UILabel()
        view.text = "Welcome, please login"
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 22)
        return view
    } ()
    
    private let usernameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Username"
        view.borderStyle = .roundedRect
        return view
    } ()
    
    private let passwordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Password"
        view.isSecureTextEntry = true
        view.borderStyle = .roundedRect
        return view
    } ()
    
    private let loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("Login", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 8
        return view
    } ()
    
    private let authorizationButton: UIButton = {
        let view = UIButton()
        view.setTitle("Authorization", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .gray
        view.layer.cornerRadius = 8
        return view
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addConstraints()
    }
    
    private func addConstraints() {
        view.addSubview(loginLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(authorizationButton)
        
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginLabel.snp.bottom).offset(50)
            make.width.equalToSuperview().offset(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(usernameTextField)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
        }
        
        authorizationButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
        }
    }

    

}
