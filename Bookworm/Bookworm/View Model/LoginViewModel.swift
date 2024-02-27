//
//  LoginViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 26/02/24.
//

import Foundation

extension LoginView {
    final class LoginViewModel: ObservableObject {
        @Published var storage: Storage
        
        @Published var email = ""
        @Published var password = ""
        @Published var isLoadingState = false
        @Published var errorTitle = ""
        @Published var errorMessage = ""
        @Published var showingError = false
        @Published var showingCreateAccountView = false
        
        func isValid() -> Bool {
            (!self.email.isEmpty && !self.password.isEmpty)
        }
        
        func backToFocusField() -> Field? {
            if self.email.isEmpty {
                return .email
            } else if self.password.isEmpty {
                return .password
            } else {
                return nil
            }
        }
        
        private func getToken() async throws {
            let loginData = ("\(self.email):\(self.password)").data(using: .utf8)?.base64EncodedString()
            
            guard let credentials = loginData else {
                throw NetworkError.faliedToEncodeData
            }
            
            let data = try await NetworkService.request(
                endpoint: APIEndpoints.login.rawValue,
                requestValue: "\(RequestValue.basic.rawValue) \(credentials)",
                for: HeaderField.authorization.rawValue,
                httpMethod: .post
            )
            
            try Keychain.create(account: self.email, service: KeychainService.authorization.rawValue, tokenData: data)
        }
        
        private func getUser() async throws {
            await MainActor.run {
                self.isLoadingState = true
            }
            
            try await self.getToken()
            
            let tokenData = try Keychain.read(account: self.email, service: KeychainService.authorization.rawValue)
            
            let token = try JSONDecoder().decode(Token.self, from: tokenData)
            
            let data = try await NetworkService.request(
                endpoint: APIEndpoints.getUser.rawValue,
                requestValue: "\(RequestValue.bearer.rawValue) \(token.value)",
                for: HeaderField.authorization.rawValue,
                httpMethod: .get
            )
            
            let user = try JSONDecoder.decoder.decode(User.self, from: data)
            
            try storage.createUser(user)
            
            await MainActor.run {
                self.isLoadingState = false
            }
        }
        
        func login() {
            Task {
                do {
                    try await self.getUser()
                } catch let error {
                    await MainActor.run {
                        self.errorTitle = "Login Error"
                        self.errorMessage = error.localizedDescription
                        self.isLoadingState = false
                        self.showingError = true
                    }
                }
            }
        }
        
        init(storage: Storage) {
            _storage = Published(initialValue: storage)
        }
    }
}

extension JSONDecoder {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
