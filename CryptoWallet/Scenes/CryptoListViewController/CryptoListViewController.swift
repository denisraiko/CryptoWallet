//
//  CryptoListViewController.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 24.05.25.
//

import UIKit

final class CryptoListViewController: UIViewController {
    
    private let cryptoListView = CryptoListView()
    private let viewModel = CryptoListViewModel()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    weak var coordinator: AppCoordinator?
    
    override func loadView() {
        self.view = cryptoListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.fetchCryptos()
        
        
        cryptoListView.tableView.delegate = self
        cryptoListView.tableView.dataSource = self
        
        cryptoListView.tableView.register(CryptoListCell.self, forCellReuseIdentifier: "CryptoListCell")
        
        setupActions()
        setupActivityIndicator()
        
    }
    
  
    
    // MARK: Settings ActivityIndicator

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: Settings Actions
    
    private func setupActions() {
        cryptoListView.refreshButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        cryptoListView.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)

        cryptoListView.onSortAscending = { [weak self] in
            self?.viewModel.sortCryptos(by: .ascending)
        }

        cryptoListView.onSortDescending = { [weak self] in
            self?.viewModel.sortCryptos(by: .descending)
        }
        
        cryptoListView.onRefresh = { [weak self] in
            self?.viewModel.refreshData()
        }
        
        cryptoListView.onLogout = { [weak self] in
            AuthService.logout()
            self?.coordinator?.showLogin()
        }
    }
    
    // MARK: Settings objc methods

    
    @objc private func refreshTapped() {
        
    }
    
    @objc private func logoutTapped() {
        
    }
    
}

// MARK: CryptoListViewModelDelegate

extension CryptoListViewController: CryptoListViewModelDelegate {
    func didUpdateCryptos() {
        cryptoListView.tableView.reloadData()
    }
    
    func didStartLoading() {
        activityIndicator.startAnimating()
    }

    func didFinishLoading() {
        activityIndicator.stopAnimating()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate


extension CryptoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoListCell", for: indexPath) as? CryptoListCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.cryptos[indexPath.row])
        cell.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1.00)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCrypto = viewModel.cryptos[indexPath.row]
        coordinator?.showCryptoDetail(for: selectedCrypto)
    }
    
    
}
