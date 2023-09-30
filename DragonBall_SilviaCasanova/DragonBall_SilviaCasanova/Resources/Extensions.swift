//
//  Extensions.swift
//  DragonBall_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 29/9/23.
//

import UIKit

enum SpinnerAction {
    case add
    case remove
}

extension UIViewController {
    
    // MARK: - Spinner
    func manageSpinner(inside view: UIView, action: SpinnerAction, yOffset: CGFloat? = nil) {
        
        switch action {
            //Spinner appears
        case .add:
            let spinner = UIActivityIndicatorView()
            let spinnerView = SpinnerView()
            
         
            // Spinner configuration
            view.addSubview(spinnerView)
            // Constraints
            spinnerView.addSubview(spinner)
            spinnerView.alpha = 0
            spinnerView.translatesAutoresizingMaskIntoConstraints = false
            spinnerView.widthAnchor.constraint(equalToConstant: 70).isActive = true
            spinnerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yOffset ?? 0).isActive = true
            spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            // Position
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.centerYAnchor.constraint(equalTo: spinnerView.centerYAnchor).isActive = true
            spinner.centerXAnchor.constraint(equalTo: spinnerView.centerXAnchor).isActive = true
            spinner.color = .orange
            spinner.startAnimating()
            //Animation
            UIView.animate(withDuration: 1) { spinnerView.alpha = 1 }
        // Spinner disappear
        case .remove:
            let spinnerView = view.subviews.filter({ $0.isKind(of: SpinnerView.self) })
            spinnerView.forEach { spinner in
                UIView.animate(withDuration: 0.2, animations: {
                    spinner.alpha = 0
                }, completion: { (success) in
                    guard success else { return }
                    spinner.removeFromSuperview()
                })
            }
        }
    }
}
