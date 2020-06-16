//
//  UIView+Constraints.swift
//  NextapTask
//

import UIKit

extension UIView {
    
    /// Constrains the view to the given view's anchors.
    /// - Parameter view: The `UIView` to be constrained to.
    func constraint(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
