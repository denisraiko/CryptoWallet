//
//  CryptoDetailViewController.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 26.05.25.
//

import UIKit

final class CryptoDetailViewController: UIViewController {

    private let crypto: CryptoCurrency
    private let detailView = CryptoDetailView()
    
    var coordinator: AppCoordinator?


    init(crypto: CryptoCurrency) {
        self.crypto = crypto
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = crypto.name
        view.backgroundColor = .white
        configure()
        
        
        detailView.onBack = { [weak self] in
            self?.coordinator?.showCryptoList()
        }
    }

    private func configure() {
        detailView.configure(with: crypto)
    }
}
