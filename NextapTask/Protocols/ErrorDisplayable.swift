//
//  ErrorDisplayable.swift
//  NextapTask
//

import UIKit

protocol ErrorDisplayable: class {
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
