//
//  ViewControllerExt.swift
//  IOS_Demo_UIKIT
//

import Foundation
import UIKit

// MARK: - UIViewController Extension
extension UIViewController {
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showCustomActionSheet(_ title: String, _ message: String) {
        let alert = UIAlertController(
            title: "\n\n\n\n",
            message: nil,
            preferredStyle: .actionSheet
        )
        let margin:CGFloat = 10.0
        let rect = CGRect(x: margin, y: margin, width: alert.view.bounds.size.width - margin * 4.0, height: 70)
        
        let stackView = UIStackView(frame: rect)
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        stackView.addArrangedSubview(titleLabel)

        let msgLabel = UILabel()
        msgLabel.text = message
        msgLabel.textColor = .black
        msgLabel.textAlignment = .center
        msgLabel.numberOfLines = 0
        msgLabel.font = .systemFont(ofSize: 15)
        stackView.addArrangedSubview(msgLabel)

        alert.view.addSubview(stackView)
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        )
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

