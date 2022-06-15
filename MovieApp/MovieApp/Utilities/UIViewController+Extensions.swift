//
//  UIViewController+Extensions.swift
//  HomeAssignmentIOS
//
//  Created by saurabh.a.rana on 15/01/22.
//

import UIKit

extension UIViewController {
    
    /// Function to show UIAlert View
    /// - Parameters:
    ///   - title: title
    ///   - message: message
    ///   - actionTitles: button names
    ///   - actions: Array of action closure
    func popupAlert(title: String?,
                    message: String?,
                    actionTitles:[String?],
                    actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title,
                                       style: .default,
                                       handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
}
