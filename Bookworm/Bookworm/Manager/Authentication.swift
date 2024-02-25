//
//  Authentication.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/02/24.
//

import Foundation
import LocalAuthentication

final class Authentication: ObservableObject {
    @Published var isAuthenticated = false
    
    // Access to the Local Authentication framework.
    let context = LAContext()
    
    // Return the type of the authentication and the SF Symbol.
    var typeOfBiometry: (String, String) {
        switch context.biometryType {
        case .touchID:
            return ("Touch ID", "touchid")
        case .faceID:
            return ("Face ID", "faceid")
        default:
            return ("", "lock")
        }
    }
    
    /// Checks whether authentication was successful and allows the App's internal access.
    private func authentication() {
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Authenticate to unlock your Book list"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { authenticated, error in
                DispatchQueue.main.async {
                    if authenticated {
                        self.isAuthenticated = true
                    } else {
                        if let errorDescription = error?.localizedDescription {
                            print("Error in biometric policy evaluation: \(errorDescription)")
                        }
                    }
                }
            }
        }
    }
    
    /// Runs the biometric authentication process and checks whether the process was successful or not.
    ///
    /// If everything happened successfully, access to the interior of the App is released,
    /// if not, the user is prevented from proceeding until authentication is completed successfully.
    init() {
        self.authentication()
    }
}
