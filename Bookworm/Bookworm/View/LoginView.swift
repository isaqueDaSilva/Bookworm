//
//  LoginView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 22/01/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                BookwormHeader()
                    .padding(.bottom)
                
                FieldComponent(
                    TextField("Insert your email here...", text: $viewModel.email)
                )
                
                FieldComponent(
                    SecureField("Insert your password here...", text: $viewModel.password)
                )
                
                HStack(alignment: .center) {
                    Text("No Account?")
                        .font(.headline)
                        .bold()
                    
                    Button("Create Account") {
                        viewModel.moveToCreateAccountView = true
                    }
                }
                .padding(.top, 5)
                
                ActionButton(title: "Login", mode: $viewModel.loginButtonState) { 
                    viewModel.getUser()
                }
            }
            .navigationDestination(isPresented: $viewModel.moveToCreateAccountView) {
                CreateAccountView()
            }
            .alert("Login failed", isPresented: $viewModel.showingLoginError) {
            } message: {
                Text(viewModel.loginErrorMessage)
            }
        }
    }
    
    init(authenticator: AuthenticationManager) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(authenticationManager: authenticator))
    }
}
