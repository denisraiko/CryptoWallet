//
//  CryptoListCell.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 26.05.25.
//

import UIKit
import SnapKit

class CryptoListCell: UITableViewCell {
    
    // MARK: UI Elements
    
    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let priceLabel = UILabel()
    private let changeLabel = UILabel()
    private let changeIcon = UIImageView()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Settings
    
    func configure(with crypto: CryptoCurrency) {
        iconImageView.image = UIImage(named: crypto.symbol.lowercased())
        nameLabel.text = crypto.name
        symbolLabel.text = crypto.symbol

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.decimalSeparator = "."
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        if let formattedPrice = numberFormatter.string(from: NSNumber(value: crypto.price)) {
            priceLabel.text = "\(formattedPrice)$"
        } else {
            priceLabel.text = "\(crypto.price)$"
        }
        
        let change = crypto.change
        let changeFormatted = String(format: "%.1f", abs(change)).replacingOccurrences(of: ".", with: ",")
        changeLabel.text = "\(changeFormatted)%"
        if change > 0 {
            changeIcon.image = UIImage(named: "arrowup")
        } else {
            changeIcon.image = UIImage(named: "arrowdown")
        }
    }
    
    private func setupSubviews() {
        setupIconImageView()
        setupNameLabel()
        setupSymbolLabel()
        setupPriceLabel()
        setupChangeLabel()
        setupChangeIcon()
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(changeLabel)
        contentView.addSubview(changeIcon)
    }
    
    // MARK: Settings View
    
    private func setupIconImageView() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
    }
    
    // MARK: Settings Labels
    
    private func setupLabels(label: UILabel, font: UIFont, textColor: UIColor) {
        label.font = font
        label.textColor = textColor
    }
    
    private func setupNameLabel() {
        setupLabels(label: nameLabel,
                    font: UIFont(name: "Poppins-Medium", size: 18)!,
                    textColor: UIColor(red: 0.15, green: 0.15, blue: 0.24, alpha: 1.00))
        
    }
    
    private func setupSymbolLabel() {
        setupLabels(label: symbolLabel,
                    font: UIFont(name: "Poppins-Medium", size: 14)!,
                    textColor: UIColor(red: 0.58, green: 0.58, blue: 0.64, alpha: 1.00))
    }
    
    private func setupPriceLabel() {
        setupLabels(label: priceLabel,
                    font: UIFont(name: "Poppins-Medium", size: 18)!,
                    textColor: UIColor(red: 0.15, green: 0.15, blue: 0.24, alpha: 1.00))
    }
    
    private func setupChangeLabel() {
        setupLabels(label: changeLabel,
                    font: UIFont(name: "Poppins-Medium", size: 14)!,
                    textColor: UIColor(red: 0.58, green: 0.58, blue: 0.64, alpha: 1.00))
    }
    
    // MARK: Settings Icons

    private func setupChangeIcon() {
        changeIcon.contentMode = .scaleAspectFit
    }
    
    // MARK: - Settings Layout

    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(94)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(94)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        changeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        changeIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.trailing.equalTo(changeLabel.snp.leading).offset(-5)
            make.width.height.equalTo(12)
        }
        
    }
    
}
