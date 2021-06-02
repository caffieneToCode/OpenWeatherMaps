//
//  ActivityIndicator.swift
//  Weather
//
//  Created by Ashish Verma on 02/06/21.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView {
    static var spinner: UIActivityIndicatorView?
    static var style: UIActivityIndicatorView.Style = .large
    static var baseBackColor = UIColor(white: 0, alpha: 0.3)
    static var baseColor = UIColor.lightGray
    
    
    static func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        if spinner == nil, let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner?.backgroundColor = backColor
            spinner?.style = style
            spinner?.color = baseColor
            window.addSubview(spinner!)
            spinner?.startAnimating()
        }
    }
    
    static func stop() {
        if spinner != nil {
            DispatchQueue.main.async {
                spinner?.stopAnimating()
                spinner?.removeFromSuperview()
                spinner = nil
            }
        }
    }
    
    static func update() {
        if spinner != nil {
            stop()
            start()
        }
    }
}
