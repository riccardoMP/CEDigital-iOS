//
//  UIViewController+Extension.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 31/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "general_oops".localized, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "general_ok".localized, style: .default))
        self.present(alert, animated: true)
    }
    
    func showAlert(message: String, okActions: @escaping () -> ()) {
        let alert = UIAlertController(title: "general_oops".localized, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "general_ok".localized, style: .default, handler: { _ in
            okActions()
        }))
        
        self.present(alert, animated: true)
    }
}
