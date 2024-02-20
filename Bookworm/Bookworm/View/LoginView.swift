//
//  LoginView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 17/02/24.
//

import SwiftUI

struct LoginView: View {
    @FocusState private var focusedField: Field?
    @EnvironmentObject var manager: DataManager
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                BookwormHeader()
                
                Form {
                    Section("Email:") {
                        FieldComponent(
                            TextField("Insert your email here...", text: $viewModel.email)
                                .disableAutocorrection(true)
                                .focused($focusedField, equals: .email)
                                .keyboardType(.emailAddress)
                        )
                    }
                    
                    Section("Password:") {
                        FieldComponent(
                            SecureField("Insert your password here...", text: $viewModel.password)
                                .disableAutocorrection(true)
                                .focused($focusedField, equals: .password)
                        )
                    }
                }
                .formStyle(.columns)
                .padding()
                
                Button {
                    if !viewModel.validated() {
                        self.focusedField = viewModel.backToFocusField()
                    } else {
                        Task {
                            do {
                                let user = try await viewModel.getUser()
                                try manager.create(user)
                                
                                await MainActor.run {
                                    viewModel.loginButtonState = .load
                                }
                            } catch let error {
                                viewModel.displayError(error)
                            }
                        }
                    }
                } label: {
                    switch viewModel.loginButtonState {
                    case .load:
                        Text("Login")
                            .frame(maxWidth: .infinity)
                    case .loading:
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal)
                .buttonStyle(.borderedProminent)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack(spacing: 0) {
                        Text("Don't have an account?")
                            .bold()
                        Button("Resgister") {
                            viewModel.showingCreateNewAccountView = true
                        }
                    }
                    .font(.subheadline)
                }
            }
            .sheet(isPresented: $viewModel.showingCreateNewAccountView) {
                CreateAccountView()
            }
            .alert(viewModel.errorTitle, isPresented: $viewModel.showingError) {
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

extension LoginView {
    enum Field: Hashable {
        case email, password
    }
}

#Preview {
    LoginView()
        .environmentObject(DataManager())
}
