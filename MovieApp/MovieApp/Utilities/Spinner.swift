//
//  Spinner.swift
//  HomeAssignmentIOS
//
//  Created by saurabh.a.rana on 15/01/22.
//

import Foundation
import UIKit

class Spinner {
    static var spinner: UIActivityIndicatorView?
    static var style: UIActivityIndicatorView.Style = .large
    static var baseColor = UIColor.red
    
    /// Function to show UIActivityIndicatorView
    /// - Parameters:
    ///   - style: UIActivityIndicatorView.Style
    ///   - baseColor: color
    static func start(style: UIActivityIndicatorView.Style = style,
                             baseColor: UIColor = baseColor) {
        if spinner == nil, let window = UIApplication.shared.windows.first {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner?.backgroundColor = UIColor.init(red: 0.5,
                                                    green: 0.5,
                                                    blue: 0.5,
                                                    alpha: 0.5)
            spinner?.style = style
            spinner?.color = baseColor
            window.addSubview(spinner ?? UIActivityIndicatorView())
            spinner!.startAnimating()
        }
    }
    
    /// Funciton to stop / hide UIActivityIndicatorView
    static func stop() {
        if spinner != nil {
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
        }
    }
}

