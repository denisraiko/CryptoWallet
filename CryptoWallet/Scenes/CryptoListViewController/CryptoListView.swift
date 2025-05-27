//
//  CryptoListView.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 25.05.25.
//

import UIKit
import SnapKit

final class CryptoListView: UIView {
    
    var onSortAscending: (() -> Void)?
    var onSortDescending: (() -> Void)?
    
    var onRefresh: (() -> Void)?
    var onLogout: (() -> Void)?
    
    // MARK: UI Elements
    
    private let backgroundView = UIView()
    private let headerLabel = UILabel()
    private let subHeaderLabel = UILabel()
    private let menuButton = UIButton(type: .custom)
    private let infoButton = UIButton(type: .system)
    private let imageContainer = UIView()
    private let imageView = UIImageView()
    private let imageShadowView = UIImageView()
    
    private let menuPopupView = UIView()
    let refreshButton = UIButton()
    let logoutButton = UIButton()
    private var isMenuPopupViewVisible = false
    
    let sortButton = UIButton()
    private let sortOptionsView = UIView()
    private let ascendingButton = UIButton(type: .system)
    private let descendingButton = UIButton(type: .system)
    private var isSortOptionsVisible = false
    
    private let containerHeader = UILabel()
    
    let tableView = UITableView()
    
    private let tabBar = CryptoTabBarView()
    
    private let containerView = UIView()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Settings Views
    
    private func setupBackgroundView() {
        backgroundView.backgroundColor = UIColor(red: 1.00, green: 0.60, blue: 0.70, alpha: 1.00)
    }
    
    private func setupImageView() {
        imageView.image = UIImage(named: "cube")
    }
    
    private func setupImageViewShadow() {
        imageShadowView.image = UIImage(named: "cubeShadow")
    }
    
    private func setupMenuPopupView() {
        menuPopupView.backgroundColor = .white
        menuPopupView.layer.cornerRadius = 16
        menuPopupView.isHidden = true
        
    }
    
    private func setupContainerView() {
        containerView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1.00)
        containerView.layer.cornerRadius = 40
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.applyShadow(color: UIColor(red: 0.22, green: 0.24, blue: 0.49, alpha: 1.00),
                           alpha: 0.05,
                           x: 0,
                           y: 0,
                           blur: 80,
                           spread: 0)
    }
    
    private func setupSortOptionsView() {
        sortOptionsView.backgroundColor = .white
        sortOptionsView.layer.cornerRadius = 12
        sortOptionsView.isHidden = true
        sortOptionsView.layer.shadowColor = UIColor.black.cgColor
        sortOptionsView.layer.shadowOpacity = 0.1
        sortOptionsView.layer.shadowOffset = CGSize(width: 0, height: 4)
        sortOptionsView.layer.shadowRadius = 8
        
        ascendingButton.setTitle("По возрастанию", for: .normal)
        ascendingButton.titleLabel?.textAlignment = .left
        
        descendingButton.setTitle("По убыванию", for: .normal)
        descendingButton.titleLabel?.textAlignment = .left
        
        
        ascendingButton.setTitleColor(.black, for: .normal)
        descendingButton.setTitleColor(.black, for: .normal)
        
        ascendingButton.addTarget(self, action: #selector(sortAscendingTapped), for: .touchUpInside)
        descendingButton.addTarget(self, action: #selector(sortDescendingTapped), for: .touchUpInside)
    }
    
    private func hideSortOptions() {
        isSortOptionsVisible = false
        sortOptionsView.isHidden = true
    }
    
    private func hideMenuPopupView() {
        isMenuPopupViewVisible = false
        menuPopupView.isHidden = true
    }
    
    // MARK: - Settings Labels
    
    private func setupLabel(label: UILabel,
                            textLabel: String,
                            font: UIFont,
                            color: UIColor) {
        label.text = textLabel
        label.font = font
        label.textColor = color
        
    }
    
    private func setupHeaderLabel() {
        setupLabel(label: headerLabel,
                   textLabel: "Home",
                   font: UIFont(name: "Poppins-SemiBold", size: 32)!,
                   color: .white)
    }
    
    private func setupSubHeaderLabel() {
        setupLabel(label: subHeaderLabel,
                   textLabel: "Affiliate program",
                   font: UIFont(name: "Poppins-Medium", size: 20)!,
                   color: .white)
    }
    
    private func setupContainerHeader() {
        setupLabel(label: containerHeader,
                   textLabel: "Trending",
                   font: UIFont(name: "Poppins-Medium", size: 20)!,
                   color: UIColor(red: 0.10, green: 0.11, blue: 0.20, alpha: 1.00))
    }
    
    // MARK: - Settings Buttons
    
    private func setupMenuButton() {
        menuButton.setTitle("⋯", for: .normal)
        menuButton.titleLabel?.textAlignment = .center
        menuButton.setTitleColor(UIColor(red: 0.10, green: 0.11, blue: 0.20, alpha: 1.00), for: .normal)
        menuButton.backgroundColor = .white
        menuButton.alpha = 0.8
        menuButton.layer.cornerRadius = 24
        menuButton.applyShadow(color: UIColor(red: 0.22, green: 0.24, blue: 0.49, alpha: 1.00),
                               alpha: 0.05,
                               x: 0,
                               y: 20,
                               blur: 60,
                               spread: 0)
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        
        
        
        refreshButton.setTitle("Обновить", for: .normal)
        refreshButton.setTitleColor(UIColor(red: 0.15, green: 0.15, blue: 0.24, alpha: 1.00), for: .normal)
        refreshButton.setImage(UIImage(named: "rocket1"), for: .normal)
        refreshButton.imageView?.contentMode = .scaleAspectFit
        refreshButton.tintColor = .black
        refreshButton.contentHorizontalAlignment = .left
        refreshButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        refreshButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.imageView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        refreshButton.imageView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        refreshButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        
        logoutButton.setTitle("Выйти", for: .normal)
        logoutButton.setTitleColor(UIColor(red: 0.15, green: 0.15, blue: 0.24, alpha: 1.00), for: .normal)
        logoutButton.setImage(UIImage(named: "trash1"), for: .normal)
        logoutButton.imageView?.contentMode = .scaleAspectFit
        logoutButton.tintColor = .black
        logoutButton.contentHorizontalAlignment = .left
        logoutButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        logoutButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.imageView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        logoutButton.imageView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    private func setupInfoButton() {
        infoButton.setTitle("Learn more", for: .normal)
        infoButton.setTitleColor(UIColor(red: 0.15, green: 0.15, blue: 0.24, alpha: 1.00), for: .normal)
        infoButton.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        infoButton.layer.cornerRadius = 18
        infoButton.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        infoButton.titleLabel?.textAlignment = .center
    }
    
    private func setupSortButton() {
        sortButton.setImage(UIImage(named: "sortButton"), for: .normal)
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    
    
    // MARK: - Settings
    
    private func setupSubviews() {
        setupBackgroundView()
        setupImageView()
        setupImageViewShadow()
        setupMenuPopupView()
        setupHeaderLabel()
        setupSubHeaderLabel()
        setupMenuButton()
        setupContainerView()
        setupSortButton()
        setupInfoButton()
        setupContainerHeader()
        setupTableView()
        setupTabBar()
        setupSortOptionsView()
        
        addSubview(backgroundView)
        backgroundView.addSubview(headerLabel)
        backgroundView.addSubview(subHeaderLabel)
        backgroundView.addSubview(menuButton)
        imageContainer.addSubview(imageShadowView)
        imageContainer.addSubview(imageView)
        backgroundView.addSubview(imageContainer)
        backgroundView.addSubview(infoButton)
        
        addSubview(menuPopupView)
        menuPopupView.addSubview(refreshButton)
        menuPopupView.addSubview(logoutButton)
        
        addSubview(containerView)
        containerView.addSubview(sortButton)
        containerView.addSubview(containerHeader)
        containerView.addSubview(tableView)
        
        addSubview(sortOptionsView)
        sortOptionsView.addSubview(ascendingButton)
        sortOptionsView.addSubview(descendingButton)
        
        addSubview(tabBar)
    }
    
    // MARK: - Settings Layout
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        imageContainer.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(100)
            make.trailing.equalToSuperview().offset(55)
            make.width.height.equalTo(242)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageShadowView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            make.trailing.equalToSuperview().offset(-60)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(32)
            make.leading.equalToSuperview().offset(25)
        }
        
        menuButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(32)
            make.trailing.equalToSuperview().offset(-25)
            make.width.equalTo(48)
            make.height.equalTo(48)
        }
        
        subHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(126)
            make.leading.equalToSuperview().offset(25)
        }
        
        menuPopupView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(88)
            make.trailing.equalToSuperview().offset(-25)
            make.width.equalTo(157)
            make.height.equalTo(102)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.top.equalTo(menuPopupView.snp.top).offset(17)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(refreshButton.snp.bottom).offset(17)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(258)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        sortButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(288)
            make.trailing.equalToSuperview().offset(-25)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        sortOptionsView.snp.makeConstraints { make in
            make.top.equalTo(sortButton.snp.bottom).offset(8)
            make.trailing.equalTo(sortButton)
            make.width.equalTo(160)
            make.height.equalTo(90)
        }
        
        ascendingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(16)
            
        }
        
        descendingButton.snp.makeConstraints { make in
            make.top.equalTo(ascendingButton.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        infoButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(168)
            make.leading.equalToSuperview().offset(25)
            make.width.equalTo(127)
            make.height.equalTo(35)
        }
        
        containerHeader.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(288)
            make.leading.equalToSuperview().offset(25)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(328)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tabBar.snp.top)
        }
        
        tabBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(82)
        }
        
    }
    
    // MARK: Settings objc methods
    
    @objc private func sortButtonTapped() {
        if isSortOptionsVisible {
            UIView.animate(withDuration: 0.3, animations: {
                self.sortOptionsView.alpha = 0
            }, completion: { _ in
                self.sortOptionsView.isHidden = true
                self.isSortOptionsVisible = false
            })
        } else {
            sortOptionsView.alpha = 0
            sortOptionsView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.sortOptionsView.alpha = 1
            }
            isSortOptionsVisible = true
        }
    }
    
    @objc private func sortAscendingTapped() {
        onSortAscending?()
        hideSortOptions()
    }
    
    @objc private func sortDescendingTapped() {
        onSortDescending?()
        hideSortOptions()
    }
    
    @objc private func menuButtonTapped() {
        if isMenuPopupViewVisible {
            UIView.animate(withDuration: 0.3, animations: {
                self.menuPopupView.alpha = 0
            }, completion: { _ in
                self.menuPopupView.isHidden = true
                self.isMenuPopupViewVisible = false
            })
        } else {
            menuPopupView.alpha = 0
            menuPopupView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.menuPopupView.alpha = 1
            }
            isMenuPopupViewVisible = translatesAutoresizingMaskIntoConstraints
        }
    }
    
    @objc private func refreshTapped() {
        onRefresh?()
        hideSortOptions()
        hideMenuPopupView()
    }
    
    @objc private func logoutTapped() {
        onLogout?()
        hideMenuPopupView()
        hideSortOptions()
    }
    
}
