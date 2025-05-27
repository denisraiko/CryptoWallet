//
//  LoginViewController.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 24.05.25.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    private let loginViewModel = LoginViewModel()
    weak var delegate: LoginViewControllerDelegate?
    
    override func loadView() {
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel.delegate = self
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func loginButtonTapped() {
        let userName = loginView.userNameTextField.text ?? ""
        let password = loginView.passwordTextField.text ?? ""
        loginViewModel.login(userName: userName, password: password)
    }

}

// MARK: LoginViewModelDelegate

extension LoginViewController: LoginViewModelDelegate {
    func loginDidSucceed() {
        delegate?.loginDidFinish()
    }
    
    func loginDidFail() {
        let alert = UIAlertController(title: "Ошибка", message: "Введены неправильный логин или пароль", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Повторить", style: .default))
        alert.addAction(UIAlertAction(title: "Отменить", style: .destructive, handler: { _ in
            self.loginView.userNameTextField.text = ""
            self.loginView.passwordTextField.text = ""
        }))
        present(alert, animated: true)
    }
}
