//
//  AlertWithTextField.swift
//  Bookworm
//
//  Created by Isaque da Silva on 29/01/24.
//

import SwiftUI

extension View {
    func alertWithTextField(
        title: String,
        message: String,
        text: String? = nil,
        placeholder: String,
        primaryButtonTitle: String,
        secondaryButtonTitle: String,
        primaryAction: @escaping (String) -> Void,
        secondaryAction: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { field in
            if let text {
                field.text = text
            }
            field.placeholder = placeholder
        }
        
        alert.addAction(.init(title: secondaryButtonTitle, style: .cancel, handler: { _ in
            guard let secondaryAction = secondaryAction else { return }
            secondaryAction()
        }))
        
        alert.addAction(.init(title: primaryButtonTitle, style: .default, handler: { action in
            if let text = alert.textFields?[0].text {
                primaryAction(text)
                print(text)
            } else {
                primaryAction("")
                print("")
            }
        }))
        
        rootController().present(alert, animated: true)
    }
    
    private func rootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
