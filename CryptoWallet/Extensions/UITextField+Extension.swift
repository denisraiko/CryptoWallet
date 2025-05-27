//
//  UITextField+Extension.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 24.05.25.
//

import UIKit

class PaddedTextField: UITextField {
    var paddingTop: CGFloat = 0
    var paddingLeft: CGFloat = 0

    init(paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0) {
        self.paddingTop = paddingTop
        self.paddingLeft = paddingLeft
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: paddingTop, left: paddingLeft, bottom: 0, right: 0))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: paddingTop, left: paddingLeft, bottom: 0, right: 0))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: paddingTop, left: paddingLeft, bottom: 0, right: 0))
    }
}
