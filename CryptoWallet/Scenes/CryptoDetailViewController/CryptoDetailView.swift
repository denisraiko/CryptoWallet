//
//  CryptoDetailView.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 26.05.25.
//

import UIKit
import SnapKit

final class CryptoDetailView: UIView {
    
    
    var onSegmentChange: ((Int) -> Void)?
    var onBack: (() -> Void)?
    
    // MARK: - UI Elements
    
    private let backgroundView = UIView()
    let backButton = UIButton()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let changeLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    private let segmentStackView = UIStackView()
    private let segmentSelectorView = UIView()
    
    private let containerView = UIView()
    
    private let marketStatTitleLabel = UILabel()
    private let marketCapTitleLabel = UILabel()
    private let marketCapValueLabel = UILabel()
    private let supplyTitleLabel = UILabel()
    private let supplyValueLabel = UILabel()
    
    private let tabBar = CryptoTabBarView()
    
    private let segmentTitles = ["24H", "1W", "1Y", "ALL", "Point"]
    private var segmentLabels: [UILabel] = []
    private var activeIndex: Int = 0
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(with crypto: CryptoCurrency) {
        titleLabel.text = "\(crypto.name) (\(crypto.symbol.uppercased()))"
        
        
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .decimal
        priceFormatter.groupingSeparator = ","
        priceFormatter.decimalSeparator = "."
        priceFormatter.minimumFractionDigits = 2
        priceFormatter.maximumFractionDigits = 2
        
        if let formatted = priceFormatter.string(from: NSNumber(value: crypto.price)) {
            priceLabel.text = "\(formatted)$"
        }
        
        let change = crypto.change
        let changeText = String(format: "%.1f", abs(change)).replacingOccurrences(of: ".", with: ",")
        changeLabel.text = "\(changeText)%"
        changeLabel.textColor = change >= 0
        ? UIColor(red: 0.00, green: 0.70, blue: 0.31, alpha: 1.00)
        : .red
        arrowImageView.image = UIImage(named: change >= 0 ? "arrowup" : "arrowdown")
        
        let marketCapValue = crypto.cryptoData.marketcap.current_marketcap_usd
        if let formattedMarketCapValue = priceFormatter.string(from: NSNumber(value: marketCapValue)) {
            marketCapValueLabel.text = "$\(formattedMarketCapValue)"
        }
        
        let circulatingSupplyValue = crypto.cryptoData.supply.circulating
        if let formattedCirculatingSupplyValue = priceFormatter.string(from: NSNumber(value: circulatingSupplyValue)) {
            supplyValueLabel.text = "\(formattedCirculatingSupplyValue) \(crypto.symbol.uppercased())"
        }
    }
    
    // MARK: - Settings Views
    
    private func setupSubviews() {
        setupBackgroundView()
        setupBackButton()
        setupTitleLabel()
        setupPriceLabel()
        setupChangeLabel()
        setupSegmentStackView()
        setupContainerView()
        setupMarketStatisticLabels()
        setupTabBar()
        
        addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(priceLabel)
        backgroundView.addSubview(changeLabel)
        backgroundView.addSubview(arrowImageView)
        backgroundView.addSubview(segmentStackView)
        
        addSubview(containerView)
        
        containerView.addSubview(marketStatTitleLabel)
        containerView.addSubview(marketCapTitleLabel)
        containerView.addSubview(marketCapValueLabel)
        containerView.addSubview(supplyTitleLabel)
        containerView.addSubview(supplyValueLabel)
        
        addSubview(tabBar)
    }
    
    // MARK: - Settings Buttons
    
    private func setupBackButton() {
        backButton.layer.cornerRadius = 24
        backButton.clipsToBounds = true
        backButton.backgroundColor = .white
        backButton.applyShadow(color: UIColor(red: 0.22, green: 0.24, blue: 0.49, alpha: 0.05),
                               x: 0,
                               y: 20,
                               blur: 60,
                               spread: 0
        )
        
        let image = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        
        backButton.setImage(image, for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Settings Labels
    
    private func setupLabel(_ label: UILabel,
                            text: String? = nil,
                            font: UIFont,
                            color: UIColor = UIColor(red: 0.10, green: 0.11, blue: 0.20, alpha: 1.00),
                            alignment: NSTextAlignment = .left) {
        label.font = font
        label.textColor = color
        label.text = text
        label.textAlignment = alignment
    }
    
    private func setupTitleLabel() {
        setupLabel(titleLabel,
                   font: UIFont(name: "Poppins-Medium",
                                size: 14)!,
                   alignment: .center)
    }
    
    private func setupPriceLabel() {
        setupLabel(priceLabel,
                   font: UIFont(name: "Poppins-SemiBold",
                                size: 28)!,
                   alignment: .center)
    }
    
    private func setupChangeLabel() {
        setupLabel(changeLabel,
                   font: UIFont(name: "Poppins-Regular",
                                size: 14)!)
    }
    
    private func setupMarketStatisticLabels() {
        setupLabel(marketStatTitleLabel,
                   text: "Market Statistic",
                   font: UIFont(name: "Poppins-SemiBold",
                                size: 20)!)
        setupLabel(marketCapTitleLabel,
                   text: "Market capitalization",
                   font: UIFont(name: "Poppins-Regular",
                                size: 14)!)
        setupLabel(marketCapValueLabel,
                   font: UIFont(name: "Poppins-SemiBold",
                                size: 14)!)
        setupLabel(supplyTitleLabel,
                   text: "Circulating Supply",
                   font: UIFont(name: "Poppins-Regular",
                                size: 14)!)
        setupLabel(supplyValueLabel,
                   font: UIFont(name: "Poppins-SemiBold",
                                size: 14)!)
    }
    
    // MARK: - Settings Views
    
    private func setupContainerView() {
        containerView.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.8)
        containerView.layer.cornerRadius = 40
    }
    
    private func setupBackgroundView() {
        backgroundView.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.96, alpha: 1.00)
    }
    
    // MARK: - Settings segmentStackView
    
    private func setupSegmentStackView() {
        segmentStackView.axis = .horizontal
        segmentStackView.distribution = .fillEqually
        segmentStackView.backgroundColor = UIColor(red: 0.92, green: 0.94, blue: 0.95, alpha: 1.00)
        segmentStackView.layer.cornerRadius = 30
        
        setupSegments()
    }
    
    private func setupSegments() {
        segmentSelectorView.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.8)
        segmentSelectorView.applyShadow(color: UIColor(red: 0.22, green: 0.24, blue: 0.49, alpha: 0.1),
                                        x: 0,
                                        y: 20,
                                        blur: 40,
                                        spread: 0
        )
        segmentSelectorView.layer.cornerRadius = 25
        
        
        segmentStackView.insertSubview(segmentSelectorView, at: 0)
        
        for (index, title) in segmentTitles.enumerated() {
            
            let label = UILabel()
            label.text = title
            label.font = UIFont(name: "Poppins-Medium", size: 14)
            label.textColor = .darkGray
            label.textAlignment = .center
            label.backgroundColor = .clear
            label.tag = index
            
            segmentLabels.append(label)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(segmentTappped(_:)))
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(tapGesture)
            
            segmentStackView.addArrangedSubview(label)
        }
        
        
        updateSegmentSelection(animated: false)
        
        if let firstLabel = segmentLabels.first {
            segmentSelectorView.frame = firstLabel.frame
            
        }
    }
    
    private func updateSegmentSelection(animated: Bool) {
        guard activeIndex < segmentLabels.count else { return }
        let selectedLabel = segmentLabels[activeIndex]
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.segmentSelectorView.frame = selectedLabel.frame
            }
        } else {
            segmentSelectorView.frame = selectedLabel.frame
        }
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 0
        tabBar.applyShadow(
            color: UIColor(red: 0.22, green: 0.24, blue: 0.49, alpha: 1.00),
            alpha: 0.05,
            x: 0,
            y: 0,
            blur: 80,
            spread: 0
        )
    }
    
    // MARK: - Settings Layout
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(32)
            make.leading.equalToSuperview().offset(25)
            make.width.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(44)
            make.centerX.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(85)
            make.centerX.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(130)
            make.leading.equalToSuperview().offset(175)
            make.width.height.equalTo(12)
        }
        
        changeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(127)
            make.leading.equalToSuperview().offset(190)
        }
        
        segmentStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(168)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview().inset(25)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(570)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tabBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(82)
        }
        
        marketStatTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview().offset(25)
        }
        
        marketCapTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(25)
        }
        
        marketCapValueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        supplyTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(106)
            make.leading.equalToSuperview().offset(25)
        }
        
        supplyValueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(106)
            make.trailing.equalToSuperview().offset(-25)
        }
    }
    
    // MARK: Settings objc methods
    
    @objc private func segmentTappped(_ sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else { return }
        activeIndex = label.tag
        updateSegmentSelection(animated: true)
        onSegmentChange?(activeIndex)
    }
    
    
    @objc private func backTapped() {
        onBack?()
    }
}
