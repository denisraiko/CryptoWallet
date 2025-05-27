//
//  AppCoordinator.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 24.05.25.
//

import Foundation
import UIKit

enum TransitionDirection {
    case left
    case right
}

final class AppCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if AuthService.isLoggedIn() {
            showCryptoList()
        } else {
            showLogin()
        }
        
    }
    
    func showLogin() {
        let loginVC = LoginViewController()
        loginVC.delegate = self
        setRootViewController(loginVC, animated: true, direction: .right)
    }
    
    func showCryptoList() {
        let cryptoList = CryptoListViewController()
        cryptoList.coordinator = self
        setRootViewController(cryptoList, animated: true, direction: .left)
    }
    
    func showCryptoDetail(for crypto: CryptoCurrency) {
        let cryptoDetailVC = CryptoDetailViewController(crypto: crypto)
        cryptoDetailVC.coordinator = self
        setRootViewController(cryptoDetailVC, animated: true, direction: .left)
    }
    
    func logout() {
        AuthService.logout()
    }
    
    private func setRootViewController(_ viewController: UIViewController, animated: Bool = true, direction: TransitionDirection = .left) {
        if animated, let snapshot = window.snapshotView(afterScreenUpdates: true) {
            viewController.view.addSubview(snapshot)
            window.rootViewController = viewController
            window.makeKeyAndVisible()

            let offsetX = direction == .left ? -snapshot.frame.width : snapshot.frame.width

            UIView.animate(withDuration: 0.3, animations: {
                snapshot.frame = snapshot.frame.offsetBy(dx: offsetX, dy: 0)
                snapshot.alpha = 0
            }) { _ in
                snapshot.removeFromSuperview()
            }
        } else {
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }
    }
}

extension AppCoordinator: LoginViewControllerDelegate {
    func loginDidFinish() {
        showCryptoList()
    }
}
