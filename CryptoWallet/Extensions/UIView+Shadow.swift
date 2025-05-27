//
//  UIView+Shadow.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 24.05.25.
//

import UIKit

extension UIView {
    func applyShadow(color: UIColor = .black,
                     alpha: Float = 0.25,
                     x: CGFloat = 0,
                     y: CGFloat = 4,
                     blur: CGFloat = 4,
                     spread: CGFloat = 0
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2.0
        
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
        layer.masksToBounds = false
    }
}

