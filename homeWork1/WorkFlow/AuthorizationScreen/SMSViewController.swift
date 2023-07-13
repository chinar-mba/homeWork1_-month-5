//
//  SMSViewController.swift
//  homeWork1
//
//  Created by Chinara on 7/11/23.
//

import UIKit

class SMSViewController: UIViewController {

    private let ovalView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.layer.cornerRadius = 90
        view.clipsToBounds = true
        return view
    } ()
    
    private let loginLabel: UILabel = {
        let view = UILabel()
        view.text = "Please fill all the fields"
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 22)
        view.textColor = .darkGray
        return view
    } ()
    
    private let phoneNumberTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Phone number"
        view.borderStyle = .roundedRect
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.cyan.cgColor
        view.layer.borderWidth = 2.0
        view.keyboardType = .numberPad
        return view
    } ()
    
    private let authorizeButton: UIButton = {
        let view = UIButton()
        view.setTitle("Authorize", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .cyan
        view.layer.cornerRadius = 8
        view.addTarget(self, action: #selector(authorizeButtonTapped), for: .touchUpInside)
        return view
    }()
    
    let viewModel = AuthorizationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addConstraints()
    }
    
    @objc private func authorizeButtonTapped() {
        guard let sms = phoneNumberTextField.text else {
            return
        }
        
        viewModel.signInVerificationCode(with: sms) { result in
            switch result {
            case .success:
                let vc = RickAndMortyViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func addConstraints() {
        view.addSubview(ovalView)
        view.addSubview(loginLabel)
        view.addSubview(phoneNumberTextField)
        view.addSubview(authorizeButton)
        
        ovalView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(-20)
            make.width.equalTo(200)
            make.height.equalTo(ovalView.snp.width)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.leading.equalTo(50)
            make.top.equalToSuperview().offset(250)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(20)
            make.leading.equalTo(50)
            make.trailing.equalTo(-50)
            make.height.equalTo(50)
        }
        
        authorizeButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(45)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
        }
    }

}
