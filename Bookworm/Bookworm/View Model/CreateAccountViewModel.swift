//
//  CreateAccountViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 26/02/24.
//

import Foundation

extension CreateAccountView {
    final class CreateAccountViewModel: ObservableObject {
        @Published var name = ""
        @Published var username = ""
        @Published var email = ""
        @Published var password = ""
        @Published var confirmPassword = ""
        @Published var isLoadingState = false
        @Published var errorTitle = ""
        @Published var errorMessage = ""
        @Published var showingError = false
        
        func isValid() -> Bool {
            (!self.name.isEmpty && !self.username.isEmpty && !self.email.isEmpty && !self.password.isEmpty && !self.confirmPassword.isEmpty) && (self.confirmPassword == self.password)
        }
        
        func backToFocusField() -> Field? {
            if self.name.isEmpty {
                return .name
            } else if self.username.isEmpty {
                return .username
            } else if self.email.isEmpty {
                return .email
            } else if self.password.isEmpty {
                return .password
            } else if (self.confirmPassword.isEmpty) || (self.confirmPassword != self.password) {
                return .confirmPassword
            } else {
                return nil
            }
        }
        
        func craeteAccount() {
            Task {
                do {
                    await MainActor.run {
                        self.isLoadingState = true
                    }
                    
                    let newUser = CreateUser(
                        name: self.name,
                        username: self.username,
                        email: self.email,
                        password: self.password,
                        confirmPassword: self.confirmPassword
                    )
                    
                    let userEncoded = try JSONEncoder().encode(newUser)
                    
                    let _ = try await NetworkService.request(
                        endpoint: APIEndpoints.createUser.rawValue,
                        postData: userEncoded,
                        httpMethod: .post
                    )
                    
                    await MainActor.run {
                        self.isLoadingState = false
                    }
                } catch let error {
                    await MainActor.run {
                        self.errorTitle = "Falied to Create Account"
                        self.errorMessage = error.localizedDescription
                        self.showingError = true
                    }
                }
            }
        }
    }
}

extension CreateAccountView {
    struct CreateUser: Encodable {
        var name: String
        var username: String
        var email: String
        var password: String
        var confirmPassword: String
    }
}
