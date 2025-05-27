//
//  LoginView.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 24.05.25.
//

import UIKit
import SnapKit

final class LoginView: UIView {
    
    // MARK: UI Elements
    
    private let backgroundLogoContainerView = UIView()
    private let logoContainerView = UIView()
    private var backgroundIllustrationView = UIImageView()
    private var illustrationView = UIImageView()
    private var imageShadowView = UIImageView()
    private let imageView = UIImageView()
    
    var userNameTextField = PaddedTextField()
    var passwordTextField = PaddedTextField()
    
    private var userIconView = UIImageView()
    private var userIconContainer = UIView()
    
    private var passwordIconView = UIImageView()
    private var passwordIconContainer = UIView()
    
    let loginButton = UIButton(type: .system)
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.96, alpha: 1.00)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Settings LogoContainerView
    
    //    private func setupBackgroundLogoContainerView() {
    //        backgroundLogoContainerView.applyShadow(color: .black, alpha: 1, x: 0, y: 4, blur: 4) // не добавлял тень, т.к. "illustration                                                                                                background light" с выраженной                                                                                                      прозрачностью и тень видна за                                                                                                       контейнером
    //
    //    }
    
    private func setupBackgroundIllustrationView() {
        backgroundIllustrationView = UIImageView(image: UIImage(named: "illustration background light"))
        backgroundIllustrationView.contentMode = .scaleAspectFit
        backgroundIllustrationView.clipsToBounds = true
        backgroundIllustrationView.alpha = 1
    }
    
    private func setupIllustrationView() {
        illustrationView = UIImageView(image: UIImage(named: "illustration background"))
        illustrationView.contentMode = .scaleAspectFill
        illustrationView.clipsToBounds = true
        illustrationView.layer.cornerRadius = 30
        illustrationView.applyShadow(color: UIColor(red: 0.71, green: 0.25, blue: 0.46, alpha: 1.00),
                                     x: 0,
                                     y: 24,
                                     blur: 40,
                                     spread: 0
        )
    }
    
    private func setupImageShadowView() {
        imageShadowView.backgroundColor = .clear
        imageShadowView.layer.cornerRadius = 40
        imageShadowView.applyShadow(color: UIColor(red: 0.14, green: 0.10, blue: 0.31, alpha: 1.00),
                                    alpha: 0.9,
        )
    }
    
    private func setupImageView() {
        imageView.image = UIImage(named: "Pose1")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
    }
    
    // MARK: Settings TextFields
    
    private func setupTextField(_ textField: PaddedTextField, placeholder: String, iconName: String) {
        textField.placeholder = placeholder
        textField.paddingTop = 0
        textField.paddingLeft = 62
        textField.textColor = UIColor(red: 0.58, green: 0.58, blue: 0.64, alpha: 1.00)
        textField.backgroundColor = .white
        textField.alpha = 0.8
        textField.layer.cornerRadius = 25
        textField.font = UIFont(name: "Poppins-Regular", size: 15)
        
        let iconImage = UIImage(named: iconName)
        let iconView = UIImageView(image: iconImage)
        iconView.contentMode = .scaleAspectFit
        
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        iconView.frame = CGRect(x: 10, y: 0, width: 32, height: 32)
        iconContainer.addSubview(iconView)
        
        textField.leftView = iconContainer
        textField.leftViewMode = .always
    }
    
    private func setupUserNameTextField() {
        setupTextField(userNameTextField, placeholder: "UserName", iconName: "userIcon")
        userNameTextField.keyboardType = .default
        userNameTextField.isSecureTextEntry = false
    }
    
    
    private func setupPasswordTextField() {
        setupTextField(passwordTextField, placeholder: "Password", iconName: "passwordIcon")
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
    }
    
    // MARK: Settings Buttons
    
    private func setupLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor(red: 0.10, green: 0.11, blue: 0.20, alpha: 1.00)
        loginButton.layer.cornerRadius = 25
        loginButton.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 15)
        loginButton.titleLabel?.textAlignment = .center
        loginButton.layer.masksToBounds = false
        loginButton.applyShadow(color: UIColor(red: 0.10, green: 0.11, blue: 0.20, alpha: 1.00),
                                alpha: 0.1,
                                x: 0,
                                y: 20,
                                blur: 30,
        )
    }
    
    // MARK: Settings
    
    private func setupSubviews() {
        //        setupBackgroundLogoContainerView()
        setupBackgroundIllustrationView()
        setupIllustrationView()
        setupImageShadowView()
        setupImageView()
        setupUserNameTextField()
        setupPasswordTextField()
        setupLoginButton()
        
        backgroundLogoContainerView.addSubview(backgroundIllustrationView)
        logoContainerView.addSubview(backgroundLogoContainerView)
        logoContainerView.addSubview(illustrationView)
        logoContainerView.addSubview(imageShadowView)
        logoContainerView.addSubview(imageView)
        
        addSubview(backgroundLogoContainerView)
        addSubview(logoContainerView)
        addSubview(userNameTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
    }
    
    // MARK: Settings Layout
    
    private func setupConstraints() {
        logoContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(287)
            make.height.equalTo(287)
        }
        
        backgroundLogoContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundIllustrationView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(13)
            make.left.equalToSuperview().offset(44)
            make.width.equalTo(287)
            make.height.equalTo(287)
            make.centerX.equalToSuperview()
        }
        
        illustrationView.snp.makeConstraints { make in
            make.top.equalTo(backgroundIllustrationView.snp.top).offset(26)
            make.width.equalTo(287)
            make.height.equalTo(287)
            make.centerX.equalToSuperview()

        }
        
        imageShadowView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(194)
            make.width.equalTo(144)
            make.height.equalTo(54)
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(illustrationView.snp.top).offset(-20)
            make.width.equalTo(235)
            make.height.equalTo(235)
            make.centerX.equalToSuperview()
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(474)
            make.left.equalToSuperview().offset(25)
            make.width.equalTo(325)
            make.height.equalTo(55)
            make.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(25)
            make.width.equalTo(325)
            make.height.equalTo(55)
            make.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(624)
            make.leading.equalToSuperview().offset(25)
            make.width.equalTo(325)
            make.height.equalTo(55)
            make.centerX.equalToSuperview()
        }
    }
}



