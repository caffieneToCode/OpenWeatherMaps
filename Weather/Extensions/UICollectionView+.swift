//
//  UICollectionView+.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import UIKit

extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.backgroundColor = UIColor.init(white: 0.0, alpha: 0.1)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Helvetica Neue", size: 17)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }
    func restore() {
        self.backgroundView = nil
    }
}
