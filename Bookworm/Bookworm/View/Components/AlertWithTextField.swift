//
//  AlertWithTextField.swift
//  Bookworm
//
//  Created by Isaque da Silva on 29/01/24.
//

import SwiftUI

struct AlertWithTextField: ViewModifier {
    @Binding var text: String
    @Binding var isActive: Bool
    
    let title: String
    let primaryButtonTitle: String
    let secondaryButtonTitle: String
    let placeholder: String
    var isDisabled: Bool
    
    let primaryRole: ButtonRole?
    let secondaryRole: ButtonRole?
    
    let primaryAction: () -> Void
    let secondaryAction: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $isActive) {
                VStack {
                    TextField(placeholder, text: $text)
                    HStack {
                        Button(primaryButtonTitle, role: primaryRole) {
                            primaryAction()
                        }
                        .disabled(isDisabled)
                        
                        Button(secondaryButtonTitle, role: secondaryRole) {
                            guard let secondaryAction = self.secondaryAction else { return }
                            secondaryAction()
                        }
                    }
                }
            }
    }
}

extension View {
    func alertWithTextField(
        text: Binding<String>,
        isActive: Binding<Bool>,
        title: String,
        primaryButtonTitle: String,
        secondaryButtonTitle: String,
        placeholder: String,
        isDisabled: Bool,
        primaryRole: ButtonRole? = nil,
        secondaryRole: ButtonRole? = nil,
        primaryAction: @escaping () -> Void,
        secondaryAction: (() -> Void)? = nil
    ) -> some View {
        modifier(
            AlertWithTextField(
                text: text,
                isActive: isActive,
                title: title,
                primaryButtonTitle: primaryButtonTitle,
                secondaryButtonTitle: secondaryButtonTitle,
                placeholder: placeholder, 
                isDisabled: isDisabled,
                primaryRole: primaryRole,
                secondaryRole: secondaryRole,
                primaryAction: primaryAction,
                secondaryAction: secondaryAction
            )
        )
    }
}
