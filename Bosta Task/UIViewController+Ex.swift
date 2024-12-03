//
//  UIViewController+Ex.swift
//  Bosta Task
//
//  Created by Hendawi on 04/12/2024.
//

import UIKit

extension UIViewController {
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
