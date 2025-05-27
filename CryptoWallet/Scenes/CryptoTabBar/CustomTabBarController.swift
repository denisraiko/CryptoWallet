//
//  CryptoTabBarView.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 27.05.25.
//

import UIKit

final class CryptoTabBarView: UIView {
    
    // MARK: UI Elements
    
    private let stackView = UIStackView()
    private let iconNames = ["home", "grafics", "pocket", "list", "profile"]
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupIcons()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Settings Views

    private func setupView() {
        backgroundColor = .white
        applyShadow(color: UIColor(red: 0.22, green: 0.24, blue: 0.49, alpha: 1.00),
                    alpha: 0.05,
                    x: 0,
                    y: 0,
                    blur: 80,
                    spread: 0)

        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
        stackView.alignment = .center

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }

    // MARK: Settings Icons

    private func setupIcons() {
        for name in iconNames {
            let iconView = UIImageView(image: UIImage(named: name))
            iconView.contentMode = .scaleAspectFit
            iconView.isUserInteractionEnabled = false
            iconView.snp.makeConstraints { make in
                make.width.height.equalTo(24)
            }
            stackView.addArrangedSubview(iconView)
        }
    }
}
