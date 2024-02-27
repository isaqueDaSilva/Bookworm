//
//  LoginView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 25/02/24.
//

import SwiftUI

struct LoginView: View {
    @FocusState private var focusedField: Field?
    
    @StateObject private var viewModel: LoginViewModel
    
    var body: some View {
        NavigationStack {
            GeometryReader{ geo in
                VStack {
                    BookwormLogo()
                        .frame(height: geo.size.height / 4)
                    
                    VStack {
                        EntryField(
                            label: Text("Email"),
                            content: TextField("insert your email here", text: $viewModel.email),
                            leadingAccessoryView: Icons.envelope.systemImage
                        )
                        .focused($focusedField, equals: .email)
                        .padding(.bottom, 20)
                        
                        EntryField(
                            label: Text("Password"),
                            content: SecureFieldWithToggle(title: "Insert your password here...", text: $viewModel.password),
                            leadingAccessoryView: Icons.key.systemImage
                        )
                        .focused($focusedField, equals: .password)
                    }
                    .frame(height: geo.size.height / 4)
                    .padding(.bottom, 20)
                    
                    ActionButton(title: "Login", isLoadingState: viewModel.isLoadingState) {
                        if viewModel.isValid() {
                            viewModel.login()
                        } else {
                            focusedField = viewModel.backToFocusField()
                        }
                    }
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack(spacing: 0) {
                            Text("Don't have an account?")
                            Button("Create Account") {
                                viewModel.showingCreateAccountView = true
                            }
                        }
                        .font(.subheadline)
                        .bold()
                    }
                }
                .alert(
                    viewModel.errorTitle,
                    isPresented: $viewModel.showingError
                ) { } message: {
                    Text(viewModel.errorMessage)
                }
                .navigationDestination(isPresented: $viewModel.showingCreateAccountView) {
                    CreateAccountView()
                }
            }
        }
    }
    
    init(storage: Storage) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(storage: storage))
    }
}


extension LoginView {
    enum Field: Hashable {
        case email, password
    }
}

#Preview {
    LoginView(storage: Storage.preview)
}
