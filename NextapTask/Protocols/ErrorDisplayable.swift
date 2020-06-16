//
//  ErrorDisplayable.swift
//  NextapTask
//

import UIKit

protocol ErrorDisplayable: class {
    /// Displays an `Error`.
    ///
    /// When implemented by a `UIViewController`, by default it displays the error's localized description
    /// on a `UIAlertController`.
    ///
    /// - Parameter error: The `Error` to display.
    func displayError(_ error: Error)
}

extension ErrorDisplayable where Self: UIViewController {
    
    func displayError(_ error: Error) {
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
